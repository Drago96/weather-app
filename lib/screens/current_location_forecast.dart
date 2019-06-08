import 'package:flutter/material.dart';

import 'package:weather_app/models/location.dart';
import 'package:weather_app/screens/location_forecast.dart';
import 'package:weather_app/screens/locations_map.dart';
import 'package:weather_app/widgets/location_search/location_search_delegate.dart';
import 'package:weather_app/widgets/weather_forecast/current_location_weather_forecast.dart';

class CurrentLocationForecast extends StatelessWidget {
  static const routeName = '/';

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Weather'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.map),
          onPressed: () {
            Navigator.pushNamed(context, LocationsMap.routeName);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            final location = await showSearch(
              context: context,
              delegate: LocationSearchDelegate(),
            ) as Location;

            if (location != null) {
              Navigator.pushNamed(
                context,
                LocationForecast.routeName,
                arguments: LocationForecastArguments(
                  location: location,
                ),
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: PageView(
          children: <Widget>[
            CurrentLocationWeatherForecast(),
          ],
        ),
      ),
    );
  }
}
