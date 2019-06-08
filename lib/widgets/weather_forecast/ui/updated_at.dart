import 'package:flutter/material.dart';

class UpdatedAt extends StatelessWidget {
  final DateTime updatedAt;

  UpdatedAt({@required this.updatedAt}) : assert(updatedAt != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(updatedAt).format(context)}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
