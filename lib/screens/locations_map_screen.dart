import 'package:flutter/material.dart';

import 'package:weather_app/widgets/locations_map/locations_map.dart';

class LocationsMapScreen extends StatelessWidget {
  static const routeName = '/locations_map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: LocationsMap(),
    );
  }
}
