import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/weather_forecast.dart';

@immutable
abstract class WeatherForecastEvent extends Equatable {
  WeatherForecastEvent([List props = const []]) : super(props);
}

abstract class FetchWeatherForecastEvent extends WeatherForecastEvent {
  FetchWeatherForecastEvent([List props = const []]) : super(props);
}

class FetchWeatherForecastByLocationName extends FetchWeatherForecastEvent {
  final String locationName;

  FetchWeatherForecastByLocationName({@required this.locationName})
      : assert(locationName != null),
        super([locationName]);
}

class FetchWeatherForecastByLocationCoordiantes
    extends FetchWeatherForecastEvent {
  final double latitude;
  final double longitude;

  FetchWeatherForecastByLocationCoordiantes(
      {@required this.latitude, @required this.longitude})
      : assert(latitude != null, longitude != null),
        super([latitude, longitude]);
}

class FetchWeatherForecastByLocationId extends FetchWeatherForecastEvent {
  final int locationId;

  FetchWeatherForecastByLocationId({@required this.locationId})
      : assert(locationId != null),
        super([locationId]);
}

class SetWeatherForecast extends WeatherForecastEvent {
  final WeatherForecast weatherForecast;

  SetWeatherForecast({@required this.weatherForecast})
      : assert(weatherForecast != null),
        super([weatherForecast]);
}

class SetWeatherForecastError extends WeatherForecastEvent {
  final String error;

  SetWeatherForecastError({this.error}) : super([error]);
}
