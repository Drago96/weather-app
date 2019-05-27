import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:after_layout/after_layout.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc_provider.dart';
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
  Completer<void> _weatherForecastRefreshCompleter = Completer();
  final GlobalKey<RefreshIndicatorState> _weatherForecastRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void afterFirstLayout(BuildContext context) {
    if (_shouldShowInitialWeatherForecast()) {
      final weatherForecastBloc = WeatherForecastBlocProvider.of(context);

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
              .inMinutes <
          10;

  @override
  Widget build(BuildContext context) {
    final weatherForecastBloc = WeatherForecastBlocProvider.of(context);

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
                child: state.weatherForecast == null
                    ? ScrollableContainer(
                        child: state is WeatherForecastEmpty
                            ? null
                            : Center(
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
    );
  }
}
