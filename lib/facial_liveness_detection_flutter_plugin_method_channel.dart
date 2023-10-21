import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facial_liveness_detection_flutter_plugin_platform_interface.dart';

/// An implementation of [FacialLivenessDetectionFlutterPluginPlatform] that uses method channels.
class MethodChannelFacialLivenessDetectionFlutterPlugin extends FacialLivenessDetectionFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('facial_liveness_detection_flutter_plugin');

  @override
  void initEngine() async {
    methodChannel.invokeMethod<String>('initEngine');
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
