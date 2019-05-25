import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';
import 'package:weather_app/widgets/ui/gradient_container.dart';
import 'package:weather_app/widgets/ui/scrollable_container.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast.dart';

class WeatherForecastContainer extends StatefulWidget {
  final WeatherForecastEvent fetchWeatherForecastEvent;
  final bool isCurrentLocation;

  WeatherForecastContainer(
      {Key key,
      @required this.fetchWeatherForecastEvent,
      this.isCurrentLocation})
      : assert(fetchWeatherForecastEvent != null),
        super(key: key);

  @override
  State<WeatherForecastContainer> createState() =>
      _WeatherForecastContainerState();
}

class _WeatherForecastContainerState extends State<WeatherForecastContainer> {
  final _weatherForecastBloc = WeatherForecastBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void> _refreshCompleter = Completer();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _weatherForecastBloc,
      child: BlocListener(
        bloc: _weatherForecastBloc,
        listener: (BuildContext context, WeatherForecastState state) {
          if (state is WeatherForecastLoaded || state is WeatherForecastError) {
            _refreshCompleter?.complete();

            _refreshCompleter = Completer();
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
            bloc: _weatherForecastBloc,
            builder: (_, WeatherForecastState state) {
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () {
                  _weatherForecastBloc
                      .dispatch(widget.fetchWeatherForecastEvent);

                  return _refreshCompleter?.future;
                },
                child: GradientContainer(
                  child: state.weatherForecast == null
                      ? ScrollableContainer(
                          child: Center(
                            child: Text(
                              "Swipe to fetch weather.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        )
                      : WeatherForecast(
                          weatherForecast: state.weatherForecast,
                          isCurrentLocation: widget.isCurrentLocation,
                        ),
                  color: Colors.lightBlue,
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _weatherForecastBloc.dispose();

    super.dispose();
  }
}
