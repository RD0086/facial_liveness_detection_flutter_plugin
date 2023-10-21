import 'package:esfaceid_flutter/esfaceid_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'esfaceid_flutter_method_channel.dart';

abstract class EsfaceidFlutterPlatform extends PlatformInterface {
  /// Constructs a EsfaceidFlutterPlatform.
  EsfaceidFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static EsfaceidFlutterPlatform _instance = MethodChannelEsfaceidFlutter();

  /// The default instance of [EsfaceidFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelEsfaceidFlutter].
  static EsfaceidFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EsfaceidFlutterPlatform] when
  /// they register themselves.
  static set instance(EsfaceidFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void initEngine() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params) async{
    throw UnimplementedError('startFaceVerify() has not been implemented.');
  }

  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> config) async{
    throw UnimplementedError('startFaceVerify() has not been implemented.');
  }
}
