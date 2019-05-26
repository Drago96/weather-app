import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:bloc/bloc.dart';

import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherApi weatherApi = WeatherApi();
  final Location location = Location();

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

    if (event is SetWeatherForecast) {
      yield WeatherForecastLoaded(weatherForecast: event.weatherForecast);
    }
  }

  Stream<WeatherForecastState> _fetchWeatherForecast(
    WeatherForecastEvent event,
  ) async* {
    yield WeatherForecastLoading(currentState.weatherForecast);

    try {
      if (event is FetchWeatherForecastForCurrentLocation) {
        final currentLocation = await location.getLocation();

        final weatherForecast =
            await weatherApi.getWeatherForecastByLocationCoordinates(
          currentLocation.latitude,
          currentLocation.longitude,
        );

        yield WeatherForecastLoaded(weatherForecast: weatherForecast);
      }

      if (event is FetchWeatherForecastByLocationName) {
        final weatherForecast = await weatherApi
            .getWeatherForecastByLocationName(event.locationName);

        yield WeatherForecastLoaded(weatherForecast: weatherForecast);
      }
    } on PlatformException catch (error) {
      yield _platformExceptionError(error);
    } catch (error) {
      yield _genericWeatherForecastError();
    }
  }

  WeatherForecastError _platformExceptionError(PlatformException error) {
    if (error.code == 'PERMISSION_DENIED') {
      return _weatherForecastError(
        "Please allow the application to access device's current location.",
      );
    } else {
      return _genericWeatherForecastError();
    }
  }

  WeatherForecastError _genericWeatherForecastError() =>
      _weatherForecastError("Something went wrong. Please try again later.");

  WeatherForecastError _weatherForecastError(String error) =>
      WeatherForecastError(
        error: error,
        weatherForecast: currentState.weatherForecast,
      );
}
