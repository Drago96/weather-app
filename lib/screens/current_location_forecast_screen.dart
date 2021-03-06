import 'package:flutter/material.dart';

import 'package:weather_app/models/location.dart';
import 'package:weather_app/screens/location_forecast_screen.dart';
import 'package:weather_app/screens/locations_map_screen.dart';
import 'package:weather_app/widgets/location_search/location_search_delegate.dart';
import 'package:weather_app/widgets/weather_forecast/current_location_forecast.dart';

class CurrentLocationForecastScreen extends StatelessWidget {
  static const routeName = '/';

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Weather'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.map),
          onPressed: () async {
            final location = await Navigator.pushNamed(
              context,
              LocationsMapScreen.routeName,
            ) as Location;

            if (location != null) {
              _navigateToLocationForecast(context, location);
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final location = await showSearch(
              context: context,
              delegate: LocationSearchDelegate(),
            );

            if (location != null) {
              _navigateToLocationForecast(context, location);
            }
          },
        )
      ],
    );
  }

  void _navigateToLocationForecast(BuildContext context, Location location) {
    Navigator.pushNamed(
      context,
      LocationForecastScreen.routeName,
      arguments: LocationForecastArguments(
        location: location,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: PageView(
          children: <Widget>[
            CurrentLocationForecast(),
          ],
        ),
      ),
    );
  }
}
