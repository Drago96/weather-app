import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc_provider.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';
import 'package:weather_app/types/typedef.dart';

class CachedWeatherForecast extends StatefulWidget {
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
  State<CachedWeatherForecast> createState() => _CachedWeatherForecastState();
}

class _CachedWeatherForecastState extends State<CachedWeatherForecast> {
  WeatherForecast cachedWeatherForecast;
  bool cachedWeatherForecastLoaded = false;

  @override
  void initState() {
    super.initState();

    _getCachedWeatherForecast();
  }

  _getCachedWeatherForecast() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final existingWeatherForecast = sharedPreferences.getString(
        widget.weatherForecastKey,
      );

      if (existingWeatherForecast != null) {
        setState(() {
          cachedWeatherForecast = WeatherForecast.fromJson(
            json.decode(existingWeatherForecast),
          );
        });
      }
    } finally {
      setState(() {
        cachedWeatherForecastLoaded = true;
      });
    }
  }

  _onWeatherForecastLoaded(WeatherForecast weatherForecast) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(
      widget.weatherForecastKey,
      json.encode(weatherForecast),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!cachedWeatherForecastLoaded) {
      return Container();
    }

    return BlocListener(
      bloc: WeatherForecastBlocProvider.of(context),
      listener: (_, WeatherForecastState state) {
        if (state is WeatherForecastLoaded) {
          _onWeatherForecastLoaded(state.weatherForecast);
        }
      },
      child: WeatherForecastContainer(
        initialWeatherForecast: cachedWeatherForecast,
        fetchWeatherForecast: widget.fetchWeatherForecast,
        isCurrentLocation: widget.isCurrentLocation,
      ),
    );
  }
}
