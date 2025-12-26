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
    facial_liveness_detection_flutter_plugin: ^1.6.0
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
- 功能：全局初始化引擎，必须在调用其他方法前执行
- 入参：无
- 返回：无返回值（同步方法）
- 注意：此方法会调用 `EsLivingDetectionManager.Init()` 进行全局初始化

### `Future<Map<String, dynamic>?> verifyInit(Map<String, dynamic> options)`
- 入参：
  - `livingType`（必需）：认证类型。1：远近，2：眨眼，3：摇头，4：点头，5：张嘴，6：炫彩。可组合，如 `12` 表示远近 + 眨眼，最多 4 组
  - `recordVideo`（可选）：`true/false` 是否录制视频（默认 `false`）
  - `language`（可选）：界面语言，`CN`/`TCN`/`EN`/`JP`/`KR`/`THA`（默认 `CN`）
  - `isAutoUploadVerify`（可选）：`true/false` 是否自动上传验证消息
  - `autoUploadVeirfyMsg`（可选）：`true/false` 自动上传验证消息（注意拼写）
  - `uploadLogOnError`（可选）：`true/false` 错误时是否上传日志
  - 样式相关参数（可选）：
    - `textColor`：文字颜色（十六进制颜色值，如 `#333333`）
    - `progressBgColor`：进度条背景颜色
    - `progressStaGradient`：进度条起始渐变色
    - `progressEndGradient`：进度条结束渐变色
    - `progressColor`：进度条颜色
    - `backGroundColor`：背景颜色
    - `circleBackWidth`：圆形背景宽度（Integer）
    - `visitedStepBorderDotColor`：已访问步骤边框点颜色
    - `visitedStepFillDotColor`：已访问步骤填充点颜色
    - `nextStepBorderDotColor`：下一步骤边框点颜色
    - `nextStepFillDotColor`：下一步骤填充点颜色
    - `visitedStepSeparatorColor`：已访问步骤分隔线颜色
    - `nextStepSeparatorColor`：下一步骤分隔线颜色
    - `exitIcon`：退出图标（String）
- 返回：
  - `code`：错误码（如 `ELD_SUCCESS`）
  - `msg`：返回消息
  - `data`：返回数据
  - `token`：认证令牌
  - `videoPath`（可选）：仅在开启录制且有视频时返回

### `Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params)`
- 入参：
  - `token`（必需）：认证初始化后服务端返回的 token
  - `cameraID`（可选）：摄像头选择，`FRONT`（前置摄像头，映射为 "1"）或 `REAR`（后置摄像头，映射为 "0"），默认使用前置摄像头（"1"）
- 返回：
  - `code`：错误码（如 `ELD_SUCCESS`）
  - `msg`：返回消息
  - `data`：返回数据
  - `token`：认证令牌
  - `videoPath`（可选）：仅在开启录制且有视频时返回
- 注意：
  - 调用前需先执行 `initEngine()` 和 `verifyInit()`，否则会返回参数错误

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
