import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:esfaceid_flutter/esfaceid_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

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
  final _esfaceidFlutterPlugin = EsfaceidFlutter();

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
      platformVersion =
          await _esfaceidFlutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  String generateRandomNonce() {
    // 生成随机数作为 X-Ca-Nonce 的值
    final random = Random();
    final nonce = random.nextInt(1000000);
    return nonce.toString();
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

              Map<String, dynamic> result = await _esfaceidFlutterPlugin.verifyInit(config) ?? {};
              String code = result['code'];
              String initMsg = result['data'];
              print("code" + result['code']);
              print("msg" + result['msg']);
              print("data" + result['data']);
              if(code == "ELD_SUCCESS"){
                final String apiUrl = 'http://eface.market.alicloudapi.com/init';
                final Map<String, String> headers = {
                  'Content-Type': 'application/x-www-form-urlencoded', // 设置请求头
                  'Authorization': 'APPCODE 1c06d88bc47b4a4dbb709c48ebe6bf97', // 添加其他请求头字段
                  'X-Ca-Nonce': generateRandomNonce(), // 添加其他请求头字段
                };

                final Map<String, String> requestBody = {
                  'initMsg': initMsg,
                };

                final String encodedBody = requestBody.entries.map((entry) {
                  return '${entry.key}=${entry.value}';
                }).join('&');

                final response = await http.post(
                  Uri.parse(apiUrl),
                  headers: headers,
                  body: encodedBody,
                );

                if (response.statusCode == 200) {
                  print(response.body);
                  Map<String, dynamic> resultBody = json.decode(response.body);
                  Map<String, dynamic> resultxxx = await _esfaceidFlutterPlugin.startLivingDetect({"token": resultBody['token'],
                  "cameraID": "REAR"}) ?? {};
                  print("code" + resultxxx['code']);
                  print("msg" + resultxxx['msg']);
                  print("data" + resultxxx['data']);
                } else {
                  throw Exception('Failed to make POST request');
                }
              }
            }, child: Text('启动刷脸'))
          ]
        )
      ),
    );
  }
}
