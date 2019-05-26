import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String location;
  final bool isCurrentLocation;

  Location({@required this.location, this.isCurrentLocation = false})
      : assert(location != null);

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
          color: Colors.white,
        ),
      ),
    );

    return Row(children: locationRowContent);
  }
}
