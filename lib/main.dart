import 'package:flutter/material.dart';

import 'package:weather_app/screens/location_forecast.dart';
import 'package:weather_app/screens/weather_forecast.dart';

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
      initialRoute: WeatherForecast.routeName,
      routes: {
        WeatherForecast.routeName: (context) => WeatherForecast(),
        LocationForecast.routeName: (context) => LocationForecast(),
      },
    );
  }
}
