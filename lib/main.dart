import 'package:flutter/material.dart';

import 'package:weather_app/screens/location_forecast.dart';
import 'package:weather_app/screens/current_location_forecast.dart';
import 'package:weather_app/screens/locations_map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.white,
          ),
          title: TextStyle(
            color: Colors.white,
          ),
        ),
        hintColor: Colors.white,
      ),
      initialRoute: CurrentLocationForecast.routeName,
      routes: {
        CurrentLocationForecast.routeName: (context) =>
            CurrentLocationForecast(),
        LocationForecast.routeName: (context) => LocationForecast(),
        LocationsMap.routeName: (context) => LocationsMap(),
      },
    );
  }
}
