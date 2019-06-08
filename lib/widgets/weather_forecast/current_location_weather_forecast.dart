import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/cached_weather_forecast.dart';

class CurrentLocationWeatherForecast extends StatefulWidget {
  CurrentLocationWeatherForecast({Key key}) : super(key: key);

  @override
  State<CurrentLocationWeatherForecast> createState() =>
      _CurrentLocationWeatherForecastState();
}

class _CurrentLocationWeatherForecastState
    extends State<CurrentLocationWeatherForecast> {
  static const CURRENT_LOCATION_WEATHER_FORECAST_KEY =
      "CURRENT_LOCATION_WEATHER_FORECAST_KEY";

  final _weatherForecastBloc = WeatherForecastBloc();

  void _fetchWeatherForecastForCurrentLocation(BuildContext context) async {
    try {
      Location location = Location();

      final currentLocation = await location.getLocation();

      _weatherForecastBloc.dispatch(FetchWeatherForecastByLocationCoordiantes(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      ));
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        _weatherForecastBloc.dispatch(
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
    return BlocProvider(
      bloc: _weatherForecastBloc,
      child: CachedWeatherForecast(
        weatherForecastKey: CURRENT_LOCATION_WEATHER_FORECAST_KEY,
        fetchWeatherForecast: _fetchWeatherForecastForCurrentLocation,
        isCurrentLocation: true,
      ),
    );
  }

  @override
  void dispose() {
    _weatherForecastBloc.dispose();

    super.dispose();
  }
}
