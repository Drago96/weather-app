import 'package:flutter/material.dart';

import 'package:weather_app/widgets/weather_forecast/cached_weather_forecast_builder.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';
import 'package:weather_app/types/typedef.dart';

class CachedWeatherForecast extends StatelessWidget {
  final String weatherForecastKey;
  final FetchWeatherForecastCallback fetchWeatherForecast;

  final bool isCurrentLocation;

  CachedWeatherForecast({
    Key key,
    @required this.weatherForecastKey,
    @required this.fetchWeatherForecast,
    this.isCurrentLocation,
  })  : assert(weatherForecastKey != null, fetchWeatherForecast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedWeatherForecastBuilder(
      weatherForecastKey: weatherForecastKey,
      builder: (_, CachedWeatherForecastState state) {
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

