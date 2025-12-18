## 概述
人脸活体检测插件，支持静默、炫彩、眨眼、张嘴、摇头、点头、远近及随意动作组合，覆盖 Android / iOS / H5 / 小程序 等多端形态（可用于实人认证、刷脸认证、活体检测等场景）。

- 插件地址： https://pub.dev/packages/facial_liveness_detection_flutter_plugin
- H5 体验 DEMO： https://dev.esandcloud.com/h5demo/esand/living

## 特性
- 多动作组合：单次最多支持 4 组组合动作
- 可选视频录制：支持将本次认证视频保存到本地
- 丰富的界面定制：进度条、文字、背景、渐变色、导航样式等
- 多语言：`CN`、`TCN`、`EN`、`JP`、`KR`、`THA`
- 统一错误码：便于接入与排查

## 安装
- 在项目 `pubspec.yaml` 中添加依赖：
  ```yaml
  dependencies:
    facial_liveness_detection_flutter_plugin: ^1.5.2
  ```
- 执行：`flutter pub get`

## 平台配置
- iOS
  - iOS 11+
  - 在 `Info.plist` 增加相机权限：
    ```xml
    <key>NSCameraUsageDescription</key>
    <string>需要使用相机进行人脸活体检测</string>
    ```
  - 若开启视频录制，可能需要麦克风权限：
    ```xml
    <key>NSMicrophoneUsageDescription</key>
    <string>需要使用麦克风以优化录制体验</string>
    ```
- Android
  - 确保应用已声明相机权限（插件在运行期进行权限处理）：
    ```xml
    <uses-permission android:name="android.permission.CAMERA" />
    ```

## 快速开始
```dart
import 'package:facial_liveness_detection_flutter_plugin/facial_liveness_detection_flutter_plugin.dart';

final plugin = FacialLivenessDetectionFlutterPlugin();

// 1) 初始化引擎
plugin.initEngine();

// 2) 初始化认证（示例：远近 + 眨眼，并开启录制）
final initRes = await plugin.verifyInit({
  "livingType": 12,
  "recordVideo": true,
  "language": "CN",
  "textColor": "#333333",
  "progressBgColor": "#F3F4F6",
});

// 服务端获取到 token 后，3) 发起活体认证
final verifyRes = await plugin.startLivingDetect({
  "token": "<服务端返回的token>",
  "cameraID": "REAR"
});
```

## API
### `void initEngine()`
- 初始化引擎，无入参
- 成功时返回：`{"code":"ELD_SUCCESS","msg":"初始化引擎成功","data":""}`

### `Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> options)`
- 入参（常用）：
  - `livingType`：认证类型。1：远近，2：眨眼，3：摇头，4：点头，5：张嘴，6：炫彩。可组合，如 `12` 表示远近 + 眨眼，最多 4 组
  - `recordVideo`：`true/false` 是否录制视频（默认 `false`）
  - `language`：界面语言，`CN`/`TCN`/`EN`/`JP`/`KR`/`THA`
  - 样式相关：`textColor`、`progressBgColor`、`progressStaGradient`、`progressEndGradient`、`backGroundColor`、`circleBackWidth`、导航样式颜色等
- 返回：
  - `code`、`msg`、`data`、`token`、`videoPath`（仅在开启录制且有视频时返回）

### `Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params)`
- 入参：
  - `token`：认证初始化后服务端返回的 token
  - 可选：`cameraID`：`REAR`/`FRONT`（后置/前置），具体取值由接入方约定
- 返回：
  - `code`、`msg`、`data`、`token`、`videoPath`（仅在开启录制且有视频时返回）

### 错误码
- `ELD_SUCCESS`：成功
- `ELD_FAILED`：失败
- `ELD_PARAME_ERROR`：参数异常
- `ELD_EXCEPTION`：发生异常
- `ELD_UNSUPPORT`：不支持此活体类型
- `ELD_TIMEOUT`：执行超时
- `ELD_PERMISSION`：无法获取相机授权
- `ELD_CANCEL`：用户主动退出

## 页面样式示例
#### Android
![ANDRIOID STYLE](https://rd-esand-dev.oss-cn-shanghai.aliyuncs.com/imgs/facial_liveness_detection_flutter_plugin/imgs/android_style.png?OSSAccessKeyId=LTAI5tNZJG7Rz5icyxCpxDNg&Expires=2093821453&Signature=GXQU74nxhXjDHxc%2FpJ36jjH04Q4%3D)

#### iOS
![IOS STYLE](https://rd-esand-dev.oss-cn-shanghai.aliyuncs.com/imgs/facial_liveness_detection_flutter_plugin/imgs/ios_style.png?OSSAccessKeyId=LTAI5tNZJG7Rz5icyxCpxDNg&Expires=2093821474&Signature=dE1bs7FfBQRtOsaBoOuuZf%2FhdLs%3D)

## 其他信息
- 完整接入文档：https://esandinfo.yuque.com/yv6e1k/aa4qsg/hpxvm3vphsq4oh3g
- 后端管理控制台地址： http://openali.esandcloud.com
- 技术支持 / 定制化开发：
  - 微信：`esand_info`
  - QQ：`3626921591`
  - 电话：`13691664797`
  - 邮箱：`reid.li@foxmail.com`

![wechatqrcode](https://rd-esand-dev.oss-cn-shanghai.aliyuncs.com/imgs/facial_liveness_detection_flutter_plugin/imgs/qrcode.jpeg?OSSAccessKeyId=LTAI5tNZJG7Rz5icyxCpxDNg&Expires=2093821494&Signature=0ZxihWJ5cBWt%2F72bz%2Bahu2z272c%3D)
