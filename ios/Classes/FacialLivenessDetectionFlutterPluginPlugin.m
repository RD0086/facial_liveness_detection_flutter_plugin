#import "FacialLivenessDetectionFlutterPluginPlugin.h"
#import <EsLivingDetection/EsLivingDetection.h>

@implementation FacialLivenessDetectionFlutterPluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"facial_liveness_detection_flutter_plugin"
            binaryMessenger:[registrar messenger]];
  FacialLivenessDetectionFlutterPluginPlugin* instance = [[FacialLivenessDetectionFlutterPluginPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initEngine" isEqualToString:call.method]) {
    result([NSString stringWithFormat:@"{\"code\":\"%@\", \"msg\":\"%@\", \"data\":\"%@\"}" ,
           @"ELD_SUCCESS", @"初始化引擎成功", @""]);
  }
  else if([@"verifyInit" isEqualToString:call.method]){
      EsLivingDetectResult* ldtResult = [EsLivingDetectResult alloc];
      @try {
          do {
              // options 为 js 端调用此方法时传递的参数
              NSDictionary * options = (NSDictionary *)call.arguments;
              NSNumber *livingType =   [options objectForKey:@"livingType"];
              // livingType，不可为空
              if (livingType == nil) {
                  [ldtResult initWithCode:ELD_PARAME_ERROR msg:@"未包括参数livingType" data: @""];
                  break;
              }
              
              bool uploadLogOnError =  [[options objectForKey:@"uploadLogOnError"] boolValue];
              if (uploadLogOnError) {
//                  [LogManager startUpLog];
              }
              
              if([[options allKeys] containsObject: @"autoUploadVeirfyMsg"]){
                  bool isAutoUploadVerifyMsg = [[options objectForKey:@"autoUploadVeirfyMsg"] boolValue];
                  [[EsLivingDetectionManager LivingConfigInstance]SetIsAutoUploadVerifyMsg:isAutoUploadVerifyMsg];
              }
              
              if([[options allKeys] containsObject: @"backGroundColor"]){
                  NSString * value = [[options objectForKey:@"backGroundColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setBackGroundColor:value];
              }
              
              if([[options allKeys] containsObject: @"progressStaGradient"]){
                  NSString * value = [[options objectForKey:@"progressStaGradient"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setProgressStaGradient:value];
              }
              
              if([[options allKeys] containsObject: @"progressEndGradient"]){
                  NSString * value = [[options objectForKey:@"progressEndGradient"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setProgressEndGradient:value];
              }
              
              if([[options allKeys] containsObject: @"progressBgColor"]){
                  NSString * value = [[options objectForKey:@"progressBgColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setProgressBgColor:value];
              }
              
              if([[options allKeys] containsObject: @"progressBorderColor"]){
                  NSString * value = [[options objectForKey:@"progressBorderColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setProgressBorderColor:value];
              }
              
              if([[options allKeys] containsObject: @"textColor"]){
                  NSString * value = [[options objectForKey:@"textColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setTextColor:value];
              }
              
              if([[options allKeys] containsObject: @"progressWidth"]){
                  NSInteger value = [[options objectForKey:@"progressWidth"] intValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setProgressWidth:value];
              }
              
              if([[options allKeys] containsObject: @"exitBtnColor"]){
                  NSString * value = [[options objectForKey:@"exitBtnColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setExitBtnColor:value];
              }
              
              if([[options allKeys] containsObject: @"ldtLabelNormalColor"]){
                  NSString * value = [[options objectForKey:@"ldtLabelNormalColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setLdtLabelNormalColor:value];
              }
              
              if([[options allKeys] containsObject: @"ldtLabelProcessColor"]){
                  NSString * value = [[options objectForKey:@"ldtLabelProcessColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setLdtLabelProcessColor:value];
              }
              
              if([[options allKeys] containsObject: @"ldtLabelCompleteColor"]){
                  NSString * value = [[options objectForKey:@"ldtLabelCompleteColor"] stringValue];
                  [[EsLivingDetectionManager LivingViewStyleInstance]setLdtLabelCompleteColor:value];
              }
              
              ldtResult = [EsLivingDetectionManager verifyInit:livingType.intValue];
          }while (NO);
      } @catch(NSException* e) {
          [ldtResult initWithCode:ELD_EXCEPTION msg:e.reason data: @""];
      }
      
      NSDictionary *dataDictionary = @{
          @"code": [ldtResult getCodeStr],
          @"data": ldtResult.data == nil ? @"" : ldtResult.data,
          @"msg": ldtResult.msg == nil ? @"" : ldtResult.msg,
          @"token": ldtResult.token == nil ? @"" : ldtResult.token
      };

      NSError *error;
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDictionary
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];

      if (!error) {
          NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
          NSLog(@"JSON String: %@", jsonString);
          result(jsonString);
      } else {
          NSLog(@"Error converting dictionary to JSON: %@", error);
      }
  }else{
      result(FlutterMethodNotImplemented);
  }
}

@end
