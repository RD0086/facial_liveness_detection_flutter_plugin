
import 'facial_liveness_detection_flutter_plugin_platform_interface.dart';
typedef Function2<String> = void Function(String result);

/**
 * 人脸活体检测插件，支持静默，炫彩，眨眼，张嘴，摇头，点头，远近及随意动作组合，支持Android,IOS,H5,小程序等
 * 技术支持可联系：
 *     微信：esand_info
 *     email: reid.li@foxmail.com
 *     手机：13691664797
 */
class FacialLivenessDetectionFlutterPlugin {
  /**
   * 引擎初始化
   */
  void initEngine() {
    return FacialLivenessDetectionFlutterPluginPlatform.instance.initEngine();
  }

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
   *     language: 界面显示的语言（不分大小写），“CN”:中文，“JP”: 日文，"KR": 韩文
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
    return FacialLivenessDetectionFlutterPluginPlatform.instance.verifyInit(jsonData);
  }

  /**
   * 执行活体认证
   * @param options(JSONObject), 包括如下字段：
   *     token：认证初始化服务器端返回的数据
   * @param 包括如下几个字段
   * {
   *    "code": ”ELD_SUCCESS“, -- ELD_SUCCESS：成功，ELD_FAILED：失败，ELD_PARAME_ERROR：参数异常，ELD_EXCEPTION：发生异常，ELD_TIMEOUT：执行超时，ELD_PERMISSION：无法获取相机授权，ELD_CANCEL: 用户主动退出
   *    "msg":”成功“, -- 执行结果描述
   *    "data": "......" -- 执行结果数据
   *    "token": "" -- 本次认证token
   * }
   */
  Future<Map<String, dynamic>?> startLivingDetect(Map<String, dynamic> params){
    return FacialLivenessDetectionFlutterPluginPlatform.instance.startLivingDetect(params);
  }
}
