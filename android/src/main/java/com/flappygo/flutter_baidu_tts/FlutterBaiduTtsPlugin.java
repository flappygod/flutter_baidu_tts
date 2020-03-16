package com.flappygo.flutter_baidu_tts;

import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

import com.flappygo.flutter_baidu_tts.Voice.BaiduTTsSpeaker;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;

import androidx.annotation.NonNull;

import android.content.Context;

/**
 * FlutterbaiduttsPlugin
 */
public class FlutterBaiduTtsPlugin implements FlutterPlugin, MethodCallHandler {

    //上下文
    private Context context;

    //创建speaker
    private static BaiduTTsSpeaker speaker;

    //上下文
    public void initContext(Context context) {
        this.context = context;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_baidu_tts");
        FlutterBaiduTtsPlugin flutterbaiduttsPlugin = new FlutterBaiduTtsPlugin();
        flutterbaiduttsPlugin.initContext(flutterPluginBinding.getApplicationContext());
        channel.setMethodCallHandler(flutterbaiduttsPlugin);
        if (speaker == null) {
            speaker = new BaiduTTsSpeaker(flutterbaiduttsPlugin.context);
        }
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_baidu_tts");
        FlutterBaiduTtsPlugin flutterbaiduttsPlugin = new FlutterBaiduTtsPlugin();
        flutterbaiduttsPlugin.initContext(registrar.activity());
        channel.setMethodCallHandler(flutterbaiduttsPlugin);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "speak":
                //文本
                String text = call.argument("text");
                //说话
                if (speaker != null) {
                    speaker.speak(text);
                }
                //返回成功
                result.success(null);
                break;
            case "pause":
                //说话
                if (speaker != null) {
                    speaker.pause();
                }
                //返回成功
                result.success(null);
                break;
            case "resume":
                //说话
                if (speaker != null) {
                    speaker.resume();
                }
                //返回成功
                result.success(null);
                break;
            case "cancel":
                //说话
                if (speaker != null) {
                    speaker.stop();
                }
                //返回成功
                result.success(null);
                break;
            default:
                //没有实现
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (speaker != null) {
            speaker.release();
            speaker = null;
        }
    }
}


