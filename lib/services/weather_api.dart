import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/models/location.dart';

class WeatherApi {
  static const baseUrl = 'http://metaweather.com';

  final http.Client httpClient = http.Client();

  Future<WeatherForecast> getWeatherForecastByLocationCoordinates(
      double latitude, double longitude) async {
    final locationId = await _getLocationIdByCoordinates(latitude, longitude);

    return getWeatherForecastByLocationId(locationId);
  }

  Future<WeatherForecast> getWeatherForecastByLocationId(int locationId) async {
    final weatherForecastUrl = '$baseUrl/api/location/$locationId';
    final weatherForecastResponse =
        await this.httpClient.get(weatherForecastUrl);

    if (weatherForecastResponse.statusCode != 200) {
      throw Exception('Error getting weather for location');
    }

    final weatherForecastJson = _decodeResponseBody(weatherForecastResponse);

    return WeatherForecast.fromJson(weatherForecastJson);
  }

  Future<List<Location>> getLocationsBySearchTerm(String searchTerm) async {
    final searchUrl = '$baseUrl/api/location/search/?query=$searchTerm';
    final locationsResponse = await this.httpClient.get(searchUrl);

    if (locationsResponse.statusCode != 200) {
      throw Exception('Error searching for locations');
    }

    final locationsJson = _decodeResponseBody(locationsResponse) as List;
    final locations = locationsJson
        .map(
          (dynamic locationJson) => Location.fromJson(locationJson),
        )
        .toList();

    return locations;
  }

  Future<Location> getLocationByCoordinates(
      double latitude, double longitude) async {
    final searchUrl =
        '$baseUrl/api/location/search/?lattlong=$latitude,$longitude';
    final locationsResponse = await this.httpClient.get(searchUrl);

    if (locationsResponse.statusCode != 200) {
      throw Exception('Error finding location');
    }

    final locationsJson = _decodeResponseBody(locationsResponse) as List;
    final location = Location.fromJson(locationsJson.first);

    return location;
  }

  Future<int> _getLocationIdByCoordinates(
      double latitude, double longitude) async {
    return _getLocationIdByQuery("lattlong=$latitude,$longitude");
  }

  Future<int> _getLocationIdByQuery(String query) async {
    final locationUrl = '$baseUrl/api/location/search/?$query';
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('Error getting locationId for location');
    }

    final locationJson = _decodeResponseBody(locationResponse) as List;

    return (locationJson.first)['woeid'];
  }

  dynamic _decodeResponseBody(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
