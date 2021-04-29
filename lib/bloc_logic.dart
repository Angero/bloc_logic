library bloc_logic;

import 'dart:async';

import 'package:flutter/services.dart';

export 'package:bloc_logic/common/core/blocs/check/check_logic.dart';
export 'package:bloc_logic/common/core/blocs/radio/radio_logic.dart';
export 'package:bloc_logic/common/core/blocs/take/take_logic.dart';
export 'package:bloc_logic/common/core/blocs/valid/valid_logic.dart';
export 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
export 'package:bloc_logic/common/data/result.dart';
export 'package:bloc_logic/common/view/message_container.dart';
export 'package:bloc_logic/common/view/waiting_container.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogic {
  static const MethodChannel _channel = const MethodChannel('bloc_logic');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
