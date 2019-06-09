import 'package:flutter/material.dart';

import 'package:weather_app/models/location.dart';
import 'package:weather_app/widgets/weather_forecast/location_forecast.dart';

class LocationForecastArguments {
  final Location location;

  LocationForecastArguments({@required this.location})
      : assert(location != null);
}

class LocationForecastScreen extends StatelessWidget {
  static const routeName = '/location_forecast';

  @override
  Widget build(BuildContext context) {
    final LocationForecastArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.location.name),
      ),
      body: LocationForecast(
        location: args.location,
      ),
    );
  }
}
