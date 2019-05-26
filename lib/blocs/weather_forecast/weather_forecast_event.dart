import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/weather_forecast.dart';

abstract class WeatherForecastEvent extends Equatable {
  WeatherForecastEvent([List props = const []]) : super(props);
}

class FetchWeatherForecastByLocationName extends WeatherForecastEvent {
  final String locationName;

  FetchWeatherForecastByLocationName({@required this.locationName})
      : assert(locationName != null),
        super([locationName]);
}

class FetchWeatherForecastForCurrentLocation extends WeatherForecastEvent {}

class SetWeatherForecast extends WeatherForecastEvent {
  final WeatherForecast weatherForecast;

  SetWeatherForecast({@required this.weatherForecast})
      : assert(weatherForecast != null),
        super([weatherForecast]);
}
