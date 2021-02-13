import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Theme(
          data: ThemeData(
              cupertinoOverrideTheme:
              CupertinoThemeData(brightness: Brightness.light)),
          child: CupertinoActivityIndicator(radius: 12.0,),
        ),
      ),
    );
  }
}