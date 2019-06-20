import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:weather_app/screens/location_forecast_screen.dart';
import 'package:weather_app/screens/current_location_forecast_screen.dart';
import 'package:weather_app/screens/locations_map_screen.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}

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
      initialRoute: CurrentLocationForecastScreen.routeName,
      routes: {
        CurrentLocationForecastScreen.routeName: (context) =>
            CurrentLocationForecastScreen(),
        LocationForecastScreen.routeName: (context) => LocationForecastScreen(),
        LocationsMapScreen.routeName: (context) => LocationsMapScreen(),
      },
    );
  }
}
