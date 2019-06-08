import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String location;
  final bool isCurrentLocation;

  Location({@required this.location, bool isCurrentLocation})
      : assert(location != null),
        this.isCurrentLocation = isCurrentLocation ?? false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> locationRowContent = [];

    if (isCurrentLocation) {
      locationRowContent.addAll([
        Icon(
          Icons.location_on,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          width: 5,
        ),
      ]);
    }

    locationRowContent.add(
      Text(
        location,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );

    return Row(children: locationRowContent);
  }
}
