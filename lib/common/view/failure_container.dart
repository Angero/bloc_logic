import 'package:flutter/material.dart';

class FailureContainer extends StatelessWidget {
  final String error;
  final TextStyle style;

  const FailureContainer(
      {Key key,
      this.error = 'Error!',
      this.style = const TextStyle(
        fontSize: 12.0,
        color: Colors.black,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(this.error, style: style),
        ),
      ),
    );
  }
}
