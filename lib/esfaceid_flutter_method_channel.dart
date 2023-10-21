import 'dart:ffi';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'esfaceid_flutter_platform_interface.dart';

/// An implementation of [EsfaceidFlutterPlatform] that uses method channels.
class MethodChannelEsfaceidFlutter extends EsfaceidFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('esfaceid_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params) async{
    String result = await methodChannel.invokeMethod('startLivingDetect', params);
    return json.decode(result);
  }

  @override
  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> config) async{
    String result = await methodChannel.invokeMethod('verifyInit', config);
    return json.decode(result);
  }
}
