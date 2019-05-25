import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/weather_forecast.dart';

abstract class WeatherForecastState extends Equatable {
  WeatherForecastState([List props = const []]) : super(props);
}

class WeatherForecastEmpty extends WeatherForecastState {}

class WeatherForecastLoading extends WeatherForecastState {}

class WeatherForecastLoaded extends WeatherForecastState {
  final WeatherForecast weatherForecast;

  WeatherForecastLoaded({@required this.weatherForecast})
      : assert(weatherForecast != null),
        super([weatherForecast]);
}

class WeatherForecastError extends WeatherForecastState {
  final String error;

  WeatherForecastError({this.error}) : super([error]);
}
