import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc_provider.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/types/typedef.dart';

class CachedWeatherForecastBuilder extends StatefulWidget {
  final String weatherForecastKey;
  final BuilderCallback<CachedWeatherForecastState> builder;

  CachedWeatherForecastBuilder({
    Key key,
    @required this.weatherForecastKey,
    @required this.builder,
  })  : assert(weatherForecastKey != null, builder != null),
        super(key: key);

  @override
  State<CachedWeatherForecastBuilder> createState() =>
      _CachedWeatherForecastBuilderState();
}

class CachedWeatherForecastState {
  final WeatherForecast cachedWeatherForecast;
  final bool cachedWeatherForecastLoaded;

  const CachedWeatherForecastState(
      {@required this.cachedWeatherForecast,
      @required this.cachedWeatherForecastLoaded});
}

class _CachedWeatherForecastBuilderState
    extends State<CachedWeatherForecastBuilder> {
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
    return BlocListener(
      bloc: WeatherForecastBlocProvider.of(context),
      listener: (_, WeatherForecastState state) {
        if (state is WeatherForecastLoaded) {
          _onWeatherForecastLoaded(state.weatherForecast);
        }
      },
      child: widget.builder(
          context,
          CachedWeatherForecastState(
            cachedWeatherForecast: cachedWeatherForecast,
            cachedWeatherForecastLoaded: cachedWeatherForecastLoaded,
          )),
    );
  }
}
