import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class FetchWeatherByCityName extends WeatherEvent {
  final String city;

  FetchWeatherByCityName({@required this.city})
      : assert(city != null),
        super([city]);
}

class FetchWeatherByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchWeatherByCoordinates({@required this.latitude, @required this.longitude})
      : assert(latitude != null, longitude != null),
        super([latitude, longitude]);
}

class RefreshWeather extends WeatherEvent {
  final String city;

  RefreshWeather({@required this.city})
      : assert(city != null),
        super([city]);
}
