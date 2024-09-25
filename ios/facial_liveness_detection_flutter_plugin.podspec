#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint facial_liveness_detection_flutter_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'facial_liveness_detection_flutter_plugin'
  s.version          = '1.2.0'
  s.summary          = '人脸活体检车插件'
  s.description      = <<-DESC
人脸活体检测插件
                       DESC
  s.homepage         = 'http://www.esandinfo.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ES' => 'reid.li@foxmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.vendored_frameworks = "EsLivingDetection.framework"
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
