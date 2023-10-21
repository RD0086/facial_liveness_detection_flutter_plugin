
import 'esfaceid_flutter_platform_interface.dart';
typedef Function2<String> = void Function(String result);
class EsfaceidFlutter {
  Future<String?> getPlatformVersion() {
    return EsfaceidFlutterPlatform.instance.getPlatformVersion();
  }

  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params){
    return EsfaceidFlutterPlatform.instance.startLivingDetect(params);
  }

  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> jsonData){
    return EsfaceidFlutterPlatform.instance.verifyInit(jsonData);
  }
}
