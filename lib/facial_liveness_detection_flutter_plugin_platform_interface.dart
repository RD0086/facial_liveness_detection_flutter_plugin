import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'facial_liveness_detection_flutter_plugin_method_channel.dart';

abstract class FacialLivenessDetectionFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a FacialLivenessDetectionFlutterPluginPlatform.
  FacialLivenessDetectionFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FacialLivenessDetectionFlutterPluginPlatform _instance = MethodChannelFacialLivenessDetectionFlutterPlugin();

  /// The default instance of [FacialLivenessDetectionFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFacialLivenessDetectionFlutterPlugin].
  static FacialLivenessDetectionFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FacialLivenessDetectionFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(FacialLivenessDetectionFlutterPluginPlatform instance) {
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
