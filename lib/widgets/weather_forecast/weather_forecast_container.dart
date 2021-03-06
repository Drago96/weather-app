import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:after_layout/after_layout.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';
import 'package:weather_app/models/weather_forecast.dart' as Models;
import 'package:weather_app/widgets/ui/gradient_container.dart';
import 'package:weather_app/widgets/ui/scrollable_container.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast.dart';
import 'package:weather_app/types/typedef.dart';

class WeatherForecastContainer extends StatefulWidget {
  final FetchWeatherForecastCallback fetchWeatherForecast;

  final Models.WeatherForecast initialWeatherForecast;
  final bool isCurrentLocation;

  WeatherForecastContainer({
    Key key,
    @required this.fetchWeatherForecast,
    this.isCurrentLocation,
    this.initialWeatherForecast,
  })  : assert(fetchWeatherForecast != null),
        super(key: key);

  @override
  State<WeatherForecastContainer> createState() =>
      _WeatherForecastContainerState();
}

class _WeatherForecastContainerState extends State<WeatherForecastContainer>
    with AfterLayoutMixin<WeatherForecastContainer> {
  static const INITIAL_WEATHER_FORECAST_REFRESH_PERIOD = 10 * 60;

  Completer<void> _weatherForecastRefreshCompleter = Completer();
  final GlobalKey<RefreshIndicatorState> _weatherForecastRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void afterFirstLayout(BuildContext context) {
    if (_shouldShowInitialWeatherForecast()) {
      final weatherForecastBloc = BlocProvider.of<WeatherForecastBloc>(context);

      weatherForecastBloc.dispatch(
        SetWeatherForecast(weatherForecast: widget.initialWeatherForecast),
      );
    } else {
      _weatherForecastRefreshIndicatorKey.currentState.show();
    }
  }

  bool _shouldShowInitialWeatherForecast() =>
      widget.initialWeatherForecast != null &&
      DateTime.now()
              .difference(widget.initialWeatherForecast.updatedAt)
              .inSeconds <
          INITIAL_WEATHER_FORECAST_REFRESH_PERIOD;

  Widget _weatherForecast(BuildContext context, WeatherForecastState state) {
    if (state.weatherForecast == null) {
      return ScrollableContainer(
        child: state is WeatherForecastError
            ? Center(
                child: Text(
                  "Swipe to fetch weather.",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              )
            : null,
      );
    }

    return WeatherForecast(
      weatherForecast: state.weatherForecast,
      isCurrentLocation: widget.isCurrentLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherForecastBloc = BlocProvider.of<WeatherForecastBloc>(context);

    return BlocListener(
      bloc: weatherForecastBloc,
      listener: (BuildContext context, WeatherForecastState state) {
        if (state is WeatherForecastLoaded || state is WeatherForecastError) {
          _weatherForecastRefreshCompleter?.complete();

          _weatherForecastRefreshCompleter = Completer();
        }

        if (state is WeatherForecastError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder(
          bloc: weatherForecastBloc,
          builder: (_, WeatherForecastState state) {
            return RefreshIndicator(
              key: _weatherForecastRefreshIndicatorKey,
              onRefresh: () {
                widget.fetchWeatherForecast(context);

                return _weatherForecastRefreshCompleter?.future;
              },
              child: GradientContainer(
                child: _weatherForecast(context, state),
                color: Colors.lightBlue,
              ),
            );
          }),
    );
  }
}
