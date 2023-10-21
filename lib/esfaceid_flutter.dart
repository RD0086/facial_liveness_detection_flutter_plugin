
import 'esfaceid_flutter_platform_interface.dart';
typedef Function2<String> = void Function(String result);
class EsfaceidFlutter {
  Future<String?> getPlatformVersion() {
    return EsfaceidFlutterPlatform.instance.getPlatformVersion();
  }

  void startFaceVerify(Function2<String> resultCallback){
    return EsfaceidFlutterPlatform.instance.startFaceVerify(resultCallback);
  }

  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> jsonData){
    return EsfaceidFlutterPlatform.instance.verifyInit(jsonData);
  }
}
