import 'package:flutter/material.dart';

class MinMaxTemperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "15°/12°",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
