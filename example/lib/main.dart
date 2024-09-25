import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:facial_liveness_detection_flutter_plugin/facial_liveness_detection_flutter_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:facial_liveness_detection_flutter_plugin_example/net_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _FacialLivenessDetectionFlutterPluginPlugin = FacialLivenessDetectionFlutterPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      _FacialLivenessDetectionFlutterPluginPlugin.initEngine();
    } on PlatformException {

    }

    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('活体检测测试DEMO'),
        ),
        body: Column(
          children:[
            ElevatedButton(onPressed: () async {
              print('button pressed!');
              Map<String, dynamic> config = {
                "livingType": 6, // 活体类型
                "language": "THA" // 界面显示的语言（不分大小写），“CN”:中文，“TCN”： 繁体中文， “JP”: 日文，"KR": 韩文， “EN”: 英文，“THA”: 泰文
              };

              // 1. 认证初始化
              Map<String, dynamic> result = await _FacialLivenessDetectionFlutterPluginPlugin.verifyInit(config) ?? {};
              String code = result['code'];
              String initMsg = result['data'];
              print("code" + result['code']);
              print("msg" + result['msg']);
              print("data" + result['data']);
              if(code == "ELD_SUCCESS"){
                // 2. 获取认证TOKEN (认证授权)
                Map<String, dynamic> initResBody = await init(initMsg);
                if(initResBody.containsKey('token')){
                  // 3. 发起活体认证，进行数据采集
                  Map<String, dynamic> verifyResult = await _FacialLivenessDetectionFlutterPluginPlugin.startLivingDetect({"token": initResBody['token'],
                    "cameraID": "REAR"}) ?? {};
                  print("code" + verifyResult['code']);
                  print("msg" + verifyResult['msg']);
                  print("data" + verifyResult['data']);
                  // 4. 获取认证结果
                  Map<String, dynamic> verifyResBody = await getVerifyResult(initResBody['token'], verifyResult['data']);
                  print(verifyResBody);
                }
              }
            }, child: Text('开始活体检测'))
          ]
        )
      ),
    );
  }
}
