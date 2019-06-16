import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:weather_app/blocs/location/location_bloc.dart';
import 'package:weather_app/blocs/location/location_event.dart';
import 'package:weather_app/blocs/location/location_state.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/widgets/locations_map/location_marker_card.dart';

class LocationsMap extends StatefulWidget {
  LocationsMap({Key key}) : super(key: key);

  @override
  State<LocationsMap> createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  static const INITIAL_CAMERA_POSITION = LatLng(54.5260, 15.2551);
  static const MIN_MAX_ZOOM_PREFERENCE = MinMaxZoomPreference(3, 1000);
  static const SELECTED_LOCATION_ID = "SELECTED_LOCATION_ID";

  final LocationBloc _locationBloc = LocationBloc();
  Set<Marker> _locationMarkers = Set<Marker>();
  GoogleMapController _mapController;

  LatLng get _selectedLocation {
    if (_locationMarkers.isEmpty) {
      return null;
    }

    return _locationMarkers.first.position;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _clearLocationMarker() {
    _locationBloc.dispatch(ResetLocation());

    setState(_locationMarkers.clear);
  }

  void _fetchLocation(LatLng coordinates) {
    _clearLocationMarker();

    _locationBloc.dispatch(FetchLocationByCoordinates(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    ));
  }

  void _setLocationMarker(LatLng coordinates) {
    setState(() {
      _locationMarkers.add(
        Marker(
          markerId: MarkerId(SELECTED_LOCATION_ID),
          position: coordinates,
          icon: BitmapDescriptor.defaultMarker,
          onTap: _clearLocationMarker,
        ),
      );

      _moveToMarkedLocation();
    });
  }

  void _moveToMarkedLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _selectedLocation),
      ),
    );
  }

  void _popRouteWithLocation(BuildContext context, Location location) {
    Navigator.pop(context, location);
  }

  Widget _selectedLocationOverlay(BuildContext context, LocationState state) {
    if (state is LocationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is LocationLoaded) {
      return LocationMarkerCard(
        location: state.location,
        onClearMarkerClicked: _clearLocationMarker,
        onGoToMarkerClicked: _moveToMarkedLocation,
        onViewForecastClicked: _popRouteWithLocation,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _locationBloc,
      listener: (BuildContext context, LocationState state) {
        if (state is LocationLoaded) {
          _setLocationMarker(LatLng(
            state.location.latitude,
            state.location.longitude,
          ));
        }

        if (state is LocationError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder(
        bloc: _locationBloc,
        builder: (BuildContext context, LocationState state) {
          return Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: INITIAL_CAMERA_POSITION,
                  zoom: 3,
                ),
                minMaxZoomPreference: MIN_MAX_ZOOM_PREFERENCE,
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                markers: _locationMarkers,
                onTap: _fetchLocation,
              ),
              _selectedLocationOverlay(context, state),
            ],
          );
        },
      ),
    );
  }
}
