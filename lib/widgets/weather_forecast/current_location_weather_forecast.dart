import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc_provider.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/cached_weather_forecast.dart';

class CurrentLocationWeatherForecast extends StatelessWidget {
  static const CURRENT_LOCATION_WEATHER_FORECAST_KEY =
      "CURRENT_LOCATION_WEATHER_FORECAST_KEY";

  void _fetchWeatherForecastForCurrentLocation(BuildContext context) async {
    final weatherForecastBloc = WeatherForecastBlocProvider.of(context);

    try {
      Location location = Location();

      final currentLocation = await location.getLocation();

      weatherForecastBloc.dispatch(FetchWeatherForecastByLocationCoordiantes(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      ));
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        weatherForecastBloc.dispatch(
          SetWeatherForecastError(
            error:
                "Please allow the application to access device's current location.",
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WeatherForecastBlocProvider(
      child: CachedWeatherForecast(
        weatherForecastKey: CURRENT_LOCATION_WEATHER_FORECAST_KEY,
        fetchWeatherForecast: _fetchWeatherForecastForCurrentLocation,
        isCurrentLocation: true,
      ),
    );
  }
}
