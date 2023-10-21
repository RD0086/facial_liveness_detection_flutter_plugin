#import "FacialLivenessDetectionFlutterPluginPlugin.h"

@implementation FacialLivenessDetectionFlutterPluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"facial_liveness_detection_flutter_plugin"
            binaryMessenger:[registrar messenger]];
  FacialLivenessDetectionFlutterPluginPlugin* instance = [[FacialLivenessDetectionFlutterPluginPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
