import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';

class CurrentLocationWeatherForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherForecastContainer(
      fetchWeatherForecastEvent: FetchWeatherForecastForCurrentLocation(),
      isCurrentLocation: true,
    );
  }
}
