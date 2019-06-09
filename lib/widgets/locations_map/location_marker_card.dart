import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarkerCard extends StatelessWidget {
  final LatLng location;
  final VoidCallback onGoToMarkerClicked;
  final void Function(BuildContext context) onViewForecastClicked;
  final VoidCallback onClearMarkerClicked;

  LocationMarkerCard({
    @required this.location,
    @required this.onGoToMarkerClicked,
    @required this.onViewForecastClicked,
    @required this.onClearMarkerClicked,
  })  : assert(location != null),
        assert(onGoToMarkerClicked != null),
        assert(onViewForecastClicked != null),
        assert(onClearMarkerClicked != null);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.location_on),
                subtitle: Text(
                  'Marker',
                ),
                title: Text(
                  "Lat: ${location.latitude.toStringAsFixed(2)}, Long: ${location.longitude.toStringAsFixed(2)}",
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text("GO TO MARKER"),
                      onPressed: onGoToMarkerClicked,
                    ),
                    FlatButton(
                      child: Text('VIEW FORECAST'),
                      onPressed: () => onViewForecastClicked(context),
                    ),
                    FlatButton(
                      child: Text('CLEAR MARKER'),
                      onPressed: onClearMarkerClicked,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: 0.0,
    );
  }
}
