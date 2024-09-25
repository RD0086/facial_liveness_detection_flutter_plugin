## 概述
人脸活体检测，支持静默，炫彩，眨眼，张嘴，摇头，点头，远近及随意动作组合，支持Android,IOS,H5,小程序等 (***可用于实人认证，刷脸认证，活体检测等场景***)

插件地址： https://pub.dev/packages/facial_liveness_detection_flutter_plugin/example

## 演示视频
![](http://open.esandcloud.com/index.php/s/78XA91wLQV2y36B/download)

## 插件API接口说明

#### 引擎初始化
```java
/**
 * 引擎初始化
 */
void initEngine()
```

#### 认证初始化
```java
/**
 * 初始化
 * @param options(JSONObject), 包括如下字段：
 *     livingType：认证类型  1：远近，2：眨眼，3：摇头，4: 点头，5:张嘴，6: 炫彩
 *                  支持多动作，如传入12表示先做远近活体，后做眨眼活体，一次最多支持4组动作
 *     textColor：界面样式-字体颜色
 *     progressColor：界面样式-进度条颜色
 *     progressBgColor：界面样式-进度条背景颜色
 *     progressStaGradient：界面样式-进度条渐变开始颜色
 *     progressEndGradient：界面样式-进度条渐变结束颜色
 *     backGroundColor：界面样式-页面背景颜色
 *     circleBackWidth：界面样式-进度条宽度
 *     language: 界面显示的语言（不分大小写），“CN”:中文，“TCN”： 繁体中文， “JP”: 日文，"KR": 韩文， “EN”: 英文，“THA”: 泰文
 *     visitedStepBorderDotColor：多动作导航的边框颜色, 如 #FFC0CB
 *     visitedStepFillDotColor： 完成步骤点的填充颜色, 如 #FFC0CB
 *     nextStepBorderDotColor： 下一步骤点的填充颜色, 如 #FFC0CB
 *     nextStepFillDotColor： 下一步骤点的填充颜色, 如 #FFC0CB
 *     visitedStepSeparatorColor：  当前步骤条的颜色, 如 #FFC0CB
 *     nextStepSeparatorColor： 下一步步骤条的颜色, 如 #FFC0CB
 *     exitIcon： 退出按钮图片（BASE64字符串）
 * @return 包括如下几个字段
 * {
 *    "code": ”ELD_SUCCESS“, -- ELD_SUCCESS：成功，ELD_FAILED：失败，ELD_PARAME_ERROR：参数异常，ELD_EXCEPTION：发生异常，ELD_UNSUPPORT：不支持此活体类型
 *    "msg":”成功“, -- 执行结果描述
 *    "data": "......" -- 执行结果数据
 * }
 */
Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> jsonData){
 ```

 #### 发起活体认证
 ```java
 /**
  * 执行活体认证
  * @param options(JSONObject), 包括如下字段：
  *     token：认证初始化服务器端返回的数据
  * @param 包括如下几个字段
  * {
  *      "code": ”ELD_SUCCESS“, -- ELD_SUCCESS：成功，ELD_FAILED：失败，ELD_PARAME_ERROR：参数异常，ELD_EXCEPTION：发生异常，ELD_TIMEOUT：执行超时，ELD_PERMISSION：无法获取相机授权，ELD_CANCEL: 用户主动退出
  *      "msg":”成功“, -- 执行结果描述
  *      "data": "......" -- 执行结果数据
  *      "token": "" -- 本次认证token
  * }
  */
Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params){
```

## 页面样式修改
#### Android
![ANDRIOID STYLE](http://open.esandcloud.com/index.php/s/D44uyRlrzr3TQqQ/download)

#### IOS
![IOS STYLE](http://open.esandcloud.com/index.php/s/GUYKKqsADNOD9uY/download)

## 其他信息
1. 完整接入文档：[https://esandinfo.yuque.com/books/share/ba12bf8a-aead-48d5-ad01-be959670af6f?#](https://esandinfo.yuque.com/books/share/ba12bf8a-aead-48d5-ad01-be959670af6f?#)
2. 服务器端协议文档：[https://market.aliyun.com/products/57124001/cmapi00046021.html#sku=yuncode4002100001](https://market.aliyun.com/products/57124001/cmapi00046021.html#sku=yuncode4002100001)
3. 后端管理控制台地址: [http://openali.esandcloud.com](http://openali.esandcloud.com)
4. 技术支持/定制化开发请联系
```
微信：esand_info
qq: 3626921591
电话：13691664797
邮箱：reid.li@foxmail.com
```
![wechatqrcode](http://open.esandcloud.com/index.php/s/Lgxsc4ll9DLHvbR/download)
