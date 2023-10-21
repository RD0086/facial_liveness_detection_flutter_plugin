import 'package:flutter_test/flutter_test.dart';
import 'package:esfaceid_flutter/esfaceid_flutter_platform_interface.dart';
import 'package:esfaceid_flutter/esfaceid_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEsfaceidFlutterPlatform
    with MockPlatformInterfaceMixin
    implements EsfaceidFlutterPlatform {

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
  final EsfaceidFlutterPlatform initialPlatform = EsfaceidFlutterPlatform.instance;

  test('$MethodChannelEsfaceidFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEsfaceidFlutter>());
  });

  test('getPlatformVersion', () async {
    MockEsfaceidFlutterPlatform fakePlatform = MockEsfaceidFlutterPlatform();
    EsfaceidFlutterPlatform.instance = fakePlatform;
  });
}
