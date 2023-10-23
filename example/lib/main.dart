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
  String _platformVersion = 'Unknown';
  final _FacialLivenessDetectionFlutterPluginPlugin = FacialLivenessDetectionFlutterPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _FacialLivenessDetectionFlutterPluginPlugin.initEngine();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin examxxxple app'),
        ),
        body: Column(
          children:[
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(onPressed: () async {
              print('button pressed!');
              Map<String, dynamic> config = {
                "livingType": 23,
                "age": 30,
              };

              // 1. 认证初始化
              Map<String, dynamic> result = await _FacialLivenessDetectionFlutterPluginPlugin.verifyInit(config) ?? {};
              String code = result['code'];
              String initMsg = result['data'];
              print("code" + result['code']);
              print("msg" + result['msg']);
              print("data" + result['data']);
              if(code == "ELD_SUCCESS"){
                2. 获取认证TOKEN (认证授权)
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
            }, child: Text('启动刷脸'))
          ]
        )
      ),
    );
  }
}
