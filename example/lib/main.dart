import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_baidu_tts/flutter_baidu_tts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool flag = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await Future.delayed(new Duration(milliseconds: 5000));

    FlutterBaiduTts.speak("测试暂停和继续，测试暂停和继续");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            if (flag == false) {
              await FlutterBaiduTts.pause();
              flag = true;
            } else {
              await FlutterBaiduTts.resume();
              flag = false;
            }
          },
          child: Center(
            child: Text('Plugin example app'),
          ),
        ),
      ),
    );
  }
}
