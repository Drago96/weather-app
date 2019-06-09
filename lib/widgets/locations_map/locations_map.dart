import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  GoogleMapController _controller;
  Set<Marker> _locationMarkers = Set<Marker>();

  LatLng get _selectedLocation {
    if (_locationMarkers.isEmpty) {
      return null;
    }

    return _locationMarkers.first.position;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _clearMarker() {
    setState(_locationMarkers.clear);
  }

  void _setLocationMarker(LatLng coordinates) {
    setState(() {
      _clearMarker();

      _locationMarkers.add(
        Marker(
          markerId: MarkerId(SELECTED_LOCATION_ID),
          position: coordinates,
          icon: BitmapDescriptor.defaultMarker,
          onTap: _clearMarker,
        ),
      );

      _moveToMarkedLocation();
    });
  }

  void _moveToMarkedLocation() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _selectedLocation),
      ),
    );
  }

  void _popRouteWithCoordinates(BuildContext context) {
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: _setLocationMarker,
        ),
        _selectedLocation == null
            ? Container()
            : LocationMarkerCard(
                location: _selectedLocation,
                onClearMarkerClicked: _clearMarker,
                onGoToMarkerClicked: _moveToMarkedLocation,
                onViewForecastClicked: _popRouteWithCoordinates,
              )
      ],
    );
  }
}
