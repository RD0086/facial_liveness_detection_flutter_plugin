import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

String APPCODE = ""; // 替换为你的APPCODE
String generateRandomNonce() {
  // 生成随机数作为 X-Ca-Nonce 的值
  final random = Random();
  final nonce = random.nextInt(1000000);
  return nonce.toString();
}

Future<Map<String, dynamic>> getVerifyResult(String token, String verifyMsg) async{
  // 2. 获取认证授权
  final String apiUrl = 'http://eface.market.alicloudapi.com/verify';
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded', // 设置请求头
    'Authorization': 'APPCODE $APPCODE', // 添加其他请求头字段 (注意不可泄露，建议通过服务器端请求网关，然后APP请求服务器端进行数据转发）
    'X-Ca-Nonce': generateRandomNonce(), // 添加其他请求头字段
  };

  final Map<String, String> requestBody = {
    'token': token,
    'verifyMsg': verifyMsg,
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
    return resultBody;
  } else {
    throw Exception('Failed to make POST request');
  }
}

Future<Map<String, dynamic>> init(String initMsg) async{
  // 2. 获取认证授权
  final String apiUrl = 'http://eface.market.alicloudapi.com/init';
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded', // 设置请求头
    'Authorization': 'APPCODE $APPCODE', // 添加其他请求头字段 (注意不可泄露，建议通过服务器端请求网关，然后APP请求服务器端进行数据转发）
    'X-Ca-Nonce': generateRandomNonce(), // 添加其他请求头字段
  };

  final Map<String, String> requestBody = {
    'initMsg': initMsg
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
    return resultBody;
  } else {
    throw Exception('Failed to make POST request');
  }
}