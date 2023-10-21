
import 'facial_liveness_detection_flutter_plugin_platform_interface.dart';
typedef Function2<String> = void Function(String result);
class FacialLivenessDetectionFlutterPlugin {
  void initEngine() {
    return FacialLivenessDetectionFlutterPluginPlatform.instance.initEngine();
  }

  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params){
    return FacialLivenessDetectionFlutterPluginPlatform.instance.startLivingDetect(params);
  }

  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> jsonData){
    return FacialLivenessDetectionFlutterPluginPlatform.instance.verifyInit(jsonData);
  }
}
