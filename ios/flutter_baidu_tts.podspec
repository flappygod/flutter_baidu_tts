#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_baidu_tts.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_baidu_tts'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/FlutterBaiduTtsPlugin.h'

  s.vendored_libraries = 'Classes/BDSClientLib/libBaiduSpeechSDK.a'
  s.libraries = 'sqlite3.0','iconv.2.4.0','c++','z.1.2.5'
  s.frameworks = 'Accelerate','AudioToolbox','AVFoundation','CFNetwork','CoreLocation','CoreTelephony','GLKit','SystemConfiguration'
  s.resources='Classes/BDSClientResource/TTS/*.dat'

  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
