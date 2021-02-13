import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final String message;
  final TextStyle style;

  const MessageContainer(
      {Key key,
      this.message = '',
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
          child: Text(this.message, style: style),
        ),
      ),
    );
  }
}
