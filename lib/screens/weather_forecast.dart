import 'package:flutter/material.dart';

import 'package:weather_app/widgets/weather_forecast/current_location_weather_forecast.dart';

class WeatherForecast extends StatelessWidget {
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Weather'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.location_city),
          onPressed: () {
            Navigator.pushNamed(context, '/locations');
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
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
