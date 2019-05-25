import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherApi weatherApi;
  final Location location;

  WeatherForecastBloc({@required this.weatherApi, @required this.location})
      : assert(weatherApi != null, location != null);

  @override
  WeatherForecastState get initialState => WeatherForecastEmpty();

  @override
  Stream<WeatherForecastState> mapEventToState(
    WeatherForecastEvent event,
  ) async* {
    if (event is FetchWeatherForecastForCurrentLocation ||
        event is FetchWeatherForecastByLocationName) {
      yield* _fetchWeatherForecast(event);
    }
  }

  Stream<WeatherForecastState> _fetchWeatherForecast(
    WeatherForecastEvent event,
  ) async* {
    yield WeatherForecastLoading();

    try {
      if (event is FetchWeatherForecastForCurrentLocation) {
        final weatherForecast = await _fetchWeatherForecastForCurrentLocation();

        yield WeatherForecastLoaded(weatherForecast: weatherForecast);
      }

      if (event is FetchWeatherForecastByLocationName) {
        final weatherForecast = await weatherApi
            .getWeatherForecastByLocationName(event.locationName);

        yield WeatherForecastLoaded(weatherForecast: weatherForecast);
      }
    } catch (error) {
      yield WeatherForecastError(error: error.toString());
    }
  }

  Future<WeatherForecast> _fetchWeatherForecastForCurrentLocation() async {
    try {
      final currentLocation = await location.getLocation();

      return weatherApi.getWeatherForecastByLocationCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        throw Exception(
          "Please allow the application to access device's current location.",
        );
      }

      throw e;
    }
  }
}
