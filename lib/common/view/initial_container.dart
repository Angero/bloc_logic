import 'package:flutter/material.dart';

class InitialContainer extends StatelessWidget {
  final String comment;
  final TextStyle style;

  const InitialContainer(
      {Key key,
      this.comment = 'Initial...',
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
          child: Text(this.comment, style: style),
        ),
      ),
    );
  }
}
