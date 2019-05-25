import 'package:flutter/material.dart';

class CurrentTemperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "12°",
      style: TextStyle(
        fontSize: 50,
        color: Colors.white,
      ),
    );
  }
}
