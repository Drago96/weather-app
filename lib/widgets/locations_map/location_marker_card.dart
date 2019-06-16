import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:weather_app/models/location.dart';

class LocationMarkerCard extends StatelessWidget {
  final Location location;
  final VoidCallback onGoToMarkerClicked;
  final void Function(
    BuildContext context,
    Location location,
  ) onViewForecastClicked;
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
                  'Location Marker',
                ),
                title: Text(
                  location.name,
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text('NAVIGATE'),
                      onPressed: onGoToMarkerClicked,
                    ),
                    FlatButton(
                      child: Text('FORECAST'),
                      onPressed: () => onViewForecastClicked(context, location),
                    ),
                    FlatButton(
                      child: Text('REMOVE'),
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
