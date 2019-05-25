import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';
import 'package:weather_app/services/weather_api.dart';
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
  WeatherForecastBloc _weatherForecastBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();

    _refreshCompleter = Completer<void>();
    _weatherForecastBloc = WeatherForecastBloc(
      weatherApi: WeatherApi(httpClient: http.Client()),
      location: Location(),
    );

    _weatherForecastBloc.dispatch(widget.fetchWeatherForecastEvent);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _weatherForecastBloc,
      child: BlocListener(
        bloc: _weatherForecastBloc,
        listener: (_, WeatherForecastState state) {
          if (state is WeatherForecastLoaded || state is WeatherForecastError) {
            _refreshCompleter?.complete();

            _refreshCompleter = Completer();
          }
        },
        child: BlocBuilder(
            bloc: _weatherForecastBloc,
            builder: (_, WeatherForecastState state) {
              if (state is WeatherForecastLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherForecastLoaded) {
                return RefreshIndicator(
                  onRefresh: () {
                    _weatherForecastBloc
                        .dispatch(widget.fetchWeatherForecastEvent);

                    return _refreshCompleter?.future;
                  },
                  child: WeatherForecast(
                    weatherForecast: state.weatherForecast,
                    isCurrentLocation: widget.isCurrentLocation,
                  ),
                );
              }
              if (state is WeatherForecastError) {
                return Center(
                  child: Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              return Container();
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
