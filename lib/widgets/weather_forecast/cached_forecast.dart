import 'package:flutter/material.dart';

import 'package:weather_app/widgets/weather_forecast/cached_forecast_builder.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';
import 'package:weather_app/types/typedef.dart';

class CachedForecast extends StatelessWidget {
  final String weatherForecastKey;
  final FetchWeatherForecastCallback fetchWeatherForecast;

  final bool isCurrentLocation;

  CachedForecast({
    Key key,
    @required this.weatherForecastKey,
    @required this.fetchWeatherForecast,
    this.isCurrentLocation,
  })  : assert(weatherForecastKey != null, fetchWeatherForecast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedForecastBuilder(
      weatherForecastKey: weatherForecastKey,
      builder: (_, CachedForecastState state) {
        if (!state.cachedWeatherForecastLoaded) {
          return Container();
        }

        return WeatherForecastContainer(
          initialWeatherForecast: state.cachedWeatherForecast,
          fetchWeatherForecast: fetchWeatherForecast,
          isCurrentLocation: isCurrentLocation,
        );
      },
    );
  }
}
