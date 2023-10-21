import 'package:flutter_test/flutter_test.dart';
import 'package:facial_liveness_detection_flutter_plugin/facial_liveness_detection_flutter_plugin_platform_interface.dart';
import 'package:facial_liveness_detection_flutter_plugin/facial_liveness_detection_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFacialLivenessDetectionFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements FacialLivenessDetectionFlutterPluginPlatform {

  @override
  Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> config) {
    // TODO: implement verifyInit
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params) {
    // TODO: implement startLivingDetect
    throw UnimplementedError();
  }

  @override
  void initEngine() {
    // TODO: implement initEngine
    throw UnimplementedError();
  }
}

void main() {
  final FacialLivenessDetectionFlutterPluginPlatform initialPlatform = FacialLivenessDetectionFlutterPluginPlatform.instance;

  test('$MethodChannelFacialLivenessDetectionFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFacialLivenessDetectionFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    MockFacialLivenessDetectionFlutterPluginPlatform fakePlatform = MockFacialLivenessDetectionFlutterPluginPlatform();
    FacialLivenessDetectionFlutterPluginPlatform.instance = fakePlatform;
  });
}
