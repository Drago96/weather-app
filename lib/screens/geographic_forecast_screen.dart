import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:weather_app/widgets/weather_forecast/geographic_forecast.dart';

class GeographicForecastArguments {
  final LatLng coordinates;

  GeographicForecastArguments({@required this.coordinates})
      : assert(coordinates != null);
}

class GeographicForecastScreen extends StatelessWidget {
  static const routeName = '/geographic_forecast';

  @override
  Widget build(BuildContext context) {
    final GeographicForecastArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nearest Location",
        ),
      ),
      body: GeographicForecast(
        coordinates: args.coordinates,
      ),
    );
  }
}
