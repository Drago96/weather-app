import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/weather_forecast.dart';

@immutable
abstract class WeatherForecastState extends Equatable {
  final WeatherForecast weatherForecast;

  WeatherForecastState(this.weatherForecast, [List props = const []])
      : super([weatherForecast, props]);
}

class WeatherForecastEmpty extends WeatherForecastState {
  WeatherForecastEmpty() : super(null);
}

class WeatherForecastLoading extends WeatherForecastState {
  WeatherForecastLoading({WeatherForecast weatherForecast})
      : super(weatherForecast);
}

class WeatherForecastLoaded extends WeatherForecastState {
  WeatherForecastLoaded({@required WeatherForecast weatherForecast})
      : assert(weatherForecast != null),
        super(weatherForecast);
}

class WeatherForecastError extends WeatherForecastState {
  final String error;

  WeatherForecastError({WeatherForecast weatherForecast, this.error})
      : super(weatherForecast, [error]);
}
