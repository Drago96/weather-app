import 'package:flutter/material.dart';

class UpdatedAt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(DateTime.now()).format(context)}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
