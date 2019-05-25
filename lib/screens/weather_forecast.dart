import 'package:flutter/material.dart';

import 'package:weather_app/widgets/ui/gradient_container.dart';
import 'package:weather_app/widgets/weather/conditions.dart';
import 'package:weather_app/widgets/weather/conditions_icon.dart';
import 'package:weather_app/widgets/weather/current_temperature.dart';
import 'package:weather_app/widgets/weather/location.dart';
import 'package:weather_app/widgets/weather/min_max_temperature.dart';
import 'package:weather_app/widgets/weather/updated_at.dart';
import 'package:weather_app/widgets/weather/weather_row.dart';

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

  Widget _buildLocationAndUpdatedAtRow(BuildContext context) {
    return WeatherRow(children: <Widget>[
      Column(
        children: <Widget>[
          Location(),
          UpdatedAt(),
        ],
      ),
    ]);
  }

  Widget _buildCurrentWeatherRow(BuildContext context) {
    return WeatherRow(
      children: <Widget>[
        ConditionsIcon(),
        CurrentTemperature(),
      ],
    );
  }

  Widget _buildWeatherDetailsRow(BuildContext context) {
    return WeatherRow(
      children: <Widget>[
        Column(
          children: <Widget>[
            MinMaxTemperature(),
            Conditions()
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: GradientContainer(
          child: ListView(
            children: <Widget>[
              _buildLocationAndUpdatedAtRow(context),
              _buildCurrentWeatherRow(context),
              _buildWeatherDetailsRow(context),
            ],
          ),
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
