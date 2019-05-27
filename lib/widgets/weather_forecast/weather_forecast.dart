import 'package:flutter/material.dart';

import 'package:weather_app/models/weather_forecast.dart' as Models;
import 'package:weather_app/widgets/weather_forecast/ui/condition.dart';
import 'package:weather_app/widgets/weather_forecast/ui/condition_icon.dart';
import 'package:weather_app/widgets/weather_forecast/ui/current_temperature.dart';
import 'package:weather_app/widgets/weather_forecast/ui/location.dart';
import 'package:weather_app/widgets/weather_forecast/ui/min_max_temperature.dart';
import 'package:weather_app/widgets/weather_forecast/ui/updated_at.dart';
import 'package:weather_app/widgets/weather_forecast/ui/weather_forecast_row.dart';

class WeatherForecast extends StatelessWidget {
  final Models.WeatherForecast weatherForecast;

  final bool isCurrentLocation;

  WeatherForecast({@required this.weatherForecast, this.isCurrentLocation})
      : assert(weatherForecast != null);

  Widget _buildLocationAndUpdatedAtRow(BuildContext context) {
    return WeatherForecastRow(children: <Widget>[
      Column(
        children: <Widget>[
          Location(
            location: weatherForecast.locationName,
            isCurrentLocation: isCurrentLocation,
          ),
          UpdatedAt(
            updatedAt: weatherForecast.updatedAt,
          ),
        ],
      ),
    ]);
  }

  Widget _buildCurrentWeatherRow(BuildContext context) {
    return WeatherForecastRow(
      children: <Widget>[
        ConditionIcon(
          condition: weatherForecast.currentWeather.condition,
        ),
        SizedBox(width: 10),
        CurrentTemperature(
          currentTemperature: weatherForecast.currentWeather.currentTemperature,
        ),
      ],
    );
  }

  Widget _buildWeatherDetailsRow(BuildContext context) {
    return WeatherForecastRow(
      children: <Widget>[
        Column(
          children: <Widget>[
            MinMaxTemperature(
              maxTemperature: weatherForecast.currentWeather.maxTemperature,
              minTemperature: weatherForecast.currentWeather.minTemperature,
            ),
            Condition(
              condition: weatherForecast.currentWeather.conditionAsString,
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildLocationAndUpdatedAtRow(context),
        _buildCurrentWeatherRow(context),
        _buildWeatherDetailsRow(context),
      ],
    );
  }
}
