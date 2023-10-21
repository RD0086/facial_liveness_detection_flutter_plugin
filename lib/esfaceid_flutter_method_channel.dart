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
  void startFaceVerify(Function callback) async{
    methodChannel.setMethodCallHandler((call){
        if(call.method == "onFaceVerifyResult"){
            String result = call.arguments;
            callback(result);
        }

        return Future.value(nullptr);
    });

    methodChannel.invokeMethod('startFaceVerify');
  }

  @override
  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> config) async{
    String result = await methodChannel.invokeMethod('verifyInit', config);
    return json.decode(result);
  }
}
