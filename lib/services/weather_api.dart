import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:weather_app/models/weather_forecast.dart';

class WeatherApiClient {
  static const baseUrl = 'http://metaweather.com';

  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<WeatherForecast> getWeatherForecastByLocationCoordinates(
      double latitude, double longitude) async {
    final locationId = await _getLocationIdByCoordinates(latitude, longitude);

    return _getWeatherForecastByLocationId(locationId);
  }

  Future<WeatherForecast> getWeatherForecastByLocationName(String location) async {
    final locationId = await _getLocationIdByName(location);

    return _getWeatherForecastByLocationId(locationId);
  }

  Future<WeatherForecast> _getWeatherForecastByLocationId(int locationId) async {
    final weatherForecastUrl = '$baseUrl/api/location/$locationId';
    final weatherForecastResponse = await this.httpClient.get(weatherForecastUrl);

    if (weatherForecastResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherForecastJson = jsonDecode(weatherForecastResponse.body);

    return WeatherForecast.fromJson(weatherForecastJson);
  }

  Future<int> _getLocationIdByCoordinates(
      double latitude, double longitude) async {
    return _getLocationIdByQuery("lattlong=$latitude,$longitude");
  }

  Future<int> _getLocationIdByName(String name) async {
    return _getLocationIdByQuery("query=$name");
  }

  Future<int> _getLocationIdByQuery(String query) async {
    final locationUrl = '$baseUrl/api/location/search/?$query';
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for location');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    return (locationJson.first)['woeid'];
  }
}
