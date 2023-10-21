package com.esfaceid.esfaceid_flutter;

import android.app.Activity;
import android.util.Log;
import android.util.Printer;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.alibaba.fastjson.JSONObject;
import com.esandinfo.livingdetection.EsLivingDetectionManager;
import com.esandinfo.livingdetection.bean.EsCryptKeyType;
import com.esandinfo.livingdetection.bean.EsLDTInitConfig;
import com.esandinfo.livingdetection.bean.EsLivingDetectResult;
import com.esandinfo.livingdetection.bean.EsTitleLanguage;
import com.esandinfo.livingdetection.constants.EsLivingDetectErrorCode;
import com.esandinfo.livingdetection.util.StringUtil;

import java.util.HashMap;
import java.util.Map;

/** EsfaceidFlutterPlugin */
public class EsfaceidFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  private Map<String, Object> transEsfaceIdResult2Map(EsLivingDetectResult esLivingDetectResult){
    Map<String, Object> result = new HashMap<>();
    result.put("code", esLivingDetectResult.getCode().name());
    result.put("msg", esLivingDetectResult.getMsg());
    result.put("data", esLivingDetectResult.getData());
    result.put("token", esLivingDetectResult.getToken());
    return result;
  }

  private EsLivingDetectionManager manager;
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "esfaceid_flutter");
    channel.setMethodCallHandler(this);
    manager = new EsLivingDetectionManager(flutterPluginBinding.getApplicationContext());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("startFaceVerify")) {
      Log.i("LLL", "hello wroldxxx");
      // 向Dart发送通知
      channel.invokeMethod("onFaceVerifyResult", "来自刷脸认证的结果信息");
    }else if (call.method.equals("verifyInit")){
      // 获取传递的JSON数据
      Map<String, Object> options = (Map<String, Object>) call.arguments;
      if(!options.containsKey("livingType")){
        result.success(JSONObject.toJSONString(new EsLivingDetectResult(EsLivingDetectErrorCode.ELD_PARAME_ERROR, "参数 livingType 不能为空", "")));
        return;
      }

      int livingType = (int) options.get("livingType");
      if(options.containsKey("isAutoUploadVerify")){
        EsLivingDetectionManager.s_isAutoUploadVerifyMsg = (boolean) options.get("isAutoUploadVerify");
      }

      if(options.containsKey("textColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setTextColor((String) options.get("textColor"));
      }
      if(options.containsKey("progressBgColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setProgressBgColor((String) options.get("progressBgColor"));
      }
      if(options.containsKey("progressStaGradient")){
        EsLivingDetectionManager.LivingViewStyleInstance().setProgressStaGradient((String) options.get("progressStaGradient"));
      }
      if(options.containsKey("backGroundColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setBackGroundColor((String) options.get("backGroundColor"));
      }
      if(options.containsKey("progressEndGradient")){
        EsLivingDetectionManager.LivingViewStyleInstance().setProgressEndGradient((String) options.get("progressEndGradient"));
      }
      if(options.containsKey("circleBackWidth")){
        EsLivingDetectionManager.LivingViewStyleInstance().setCircleBackWidth((Integer) options.get("circleBackWidth"));
      }
      if(options.containsKey("progressColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setProgressColor((String) options.get("progressColor"));
      }
      if(options.containsKey("visitedStepBorderDotColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setVisitedStepBorderDotColor((String) options.get("visitedStepBorderDotColor"));
      }
      if(options.containsKey("visitedStepFillDotColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setVisitedStepFillDotColor((String) options.get("visitedStepFillDotColor"));
      }
      if(options.containsKey("nextStepBorderDotColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setNextStepBorderDotColor((String) options.get("nextStepBorderDotColor"));
      }
      if(options.containsKey("nextStepFillDotColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setNextStepFillDotColor((String) options.get("nextStepFillDotColor"));
      }
      if(options.containsKey("visitedStepSeparatorColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setVisitedStepSeparatorColor((String) options.get("visitedStepSeparatorColor"));
      }
      if(options.containsKey("nextStepSeparatorColor")){
        EsLivingDetectionManager.LivingViewStyleInstance().setNextStepSeparatorColor((String) options.get("nextStepSeparatorColor"));
      }
      if(options.containsKey("exitIcon")){
        EsLivingDetectionManager.LivingViewStyleInstance().setExitIcon((String) options.get("exitIcon"));
      }

      Boolean uploadLogOnError = (Boolean) options.get("uploadLogOnError");
      if (uploadLogOnError != null){
        manager.setUploadLogFlag(uploadLogOnError);
      }

      EsLivingDetectResult esLivingDetectResult = null;
      if(options.containsKey("language")){
        String languageStr = (String) options.get("language");
        if(StringUtil.isBlank(languageStr)){
          esLivingDetectResult = manager.verifyInit(livingType, EsTitleLanguage.CN);
        }else if("CN".equalsIgnoreCase(languageStr)){
          esLivingDetectResult = manager.verifyInit(livingType, EsTitleLanguage.CN);
        }else if("JP".equalsIgnoreCase(languageStr)){
          esLivingDetectResult = manager.verifyInit(livingType, EsTitleLanguage.JP);
        }else{
          esLivingDetectResult = manager.verifyInit(livingType, EsTitleLanguage.CN);
        }
      }else{
        esLivingDetectResult = manager.verifyInit(livingType);
      }

      result.success(JSONObject.toJSONString((esLivingDetectResult)));
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
