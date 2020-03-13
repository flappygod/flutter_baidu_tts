import 'dart:async';

import 'package:flutter/services.dart';

//百度TTS
class FlutterBaiduTts {

  //百度TTS
  static const MethodChannel _channel =
      const MethodChannel('flutter_baidu_tts');

  //播放声音
  static Future speak(text) async {
    await _channel.invokeMethod('speak', {"text": text});
  }
}
