import 'package:flutter/material.dart';

import 'package:weather_app/screens/locations.dart';
import 'package:weather_app/screens/search.dart';
import 'package:weather_app/screens/weather_forecast.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WeatherForecast(),
        '/locations': (context) => Locations(),
        '/search': (context) => Search(),
      },
    );
  }
}
