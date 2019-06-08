import 'package:flutter/material.dart';

class Condition extends StatelessWidget {
  final String condition;

  Condition({@required this.condition}) : assert(condition != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      condition,
      style: TextStyle(
        fontSize: 30,
      ),
    );
  }
}
