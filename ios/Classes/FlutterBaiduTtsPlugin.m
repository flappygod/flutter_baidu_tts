#import "FlutterBaiduTtsPlugin.h"
#import "BDSSpeechSynthesizer.h"
#import <AVFoundation/AVFoundation.h>

@implementation FlutterBaiduTtsPlugin
{
    NSString* APP_ID ;
    NSString* API_KEY ;
    NSString* SECRET_KEY ;
}

//配置sdk
-(void)configureSDK{

    APP_ID=@"19173001";
    API_KEY=@"1NToCF242MsOTFm3hLMY0zfl";
    SECRET_KEY=@"HTFgw3UbOHsAnkBuKSVcdECoDuxq1Szn";

    //设置log
    [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];
    //设置代理
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    //在线设置
    [self configureOnlineTTS];
    //离线设置
    [self configureOfflineTTS];
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_baidu_tts"
                                     binaryMessenger:[registrar messenger]];
    FlutterBaiduTtsPlugin* instance = [[FlutterBaiduTtsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

//初始化
-(instancetype)init{
    self=[super init];
    if(self){
        [self configureSDK];
    }
    return self;
}

//方法调用
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //阅读
    if ([@"speak" isEqualToString:call.method]) {
        NSString* text= call.arguments[@"text"];
        //错误
        NSError* err = nil;
        //说话
        [[BDSSpeechSynthesizer sharedInstance] speakSentence:text withError:&err];
        //说话
        result(nil);
    }
    //取消阅读
    if ([@"cancel" isEqualToString:call.method]) {
        //说话
        [[BDSSpeechSynthesizer sharedInstance] cancel];
        //说话
        result(nil);
    }
    //暂停
    if ([@"pause" isEqualToString:call.method]) {
        //说话
        [[BDSSpeechSynthesizer sharedInstance] pause];
        //说话
        result(nil);
    }
    //继续
    if ([@"resume" isEqualToString:call.method]) {
        //说话
        [[BDSSpeechSynthesizer sharedInstance] resume];
        //说话
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}


-(void)configureOnlineTTS{
    //高度
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    //返回
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    //speaker
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(BDS_SYNTHESIZER_SPEAKER_FEMALE) forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
    //超时时间
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(1) forKey:BDS_SYNTHESIZER_PARAM_ONLINE_REQUEST_TIMEOUT];
    //设置超时时间
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(REQ_CONNECTIVITY_3G) forKey:BDS_SYNTHESIZER_PARAM_ONLINE_TTS_THRESHOLD];
    
}

-(void)configureOfflineTTS{
    NSError *err = nil;
    // 在这里选择不同的离线音库（请在XCode中Add相应的资源文件），同一时间只能load一个离线音库。根据网络状况和配置，SDK可能会自动切换到离线合成。
    NSString* offlineEngineSpeechData = [[NSBundle mainBundle]
                                         pathForResource:@"Chinese_And_English_Speech_Female"
                                         ofType:@"dat"];
    
    NSString* offlineChineseAndEnglishTextData = [[NSBundle mainBundle]
                                                  pathForResource:@"Chinese_And_English_Text"
                                                  ofType:@"dat"];
    
    err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineChineseAndEnglishTextData
                                                    speechDataPath:offlineEngineSpeechData
                                                   licenseFilePath:nil
                                                       withAppCode:APP_ID];
    if(err){
        return;
    }
}



#pragma mark - implement BDSSpeechSynthesizerDelegate
- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence{
    NSLog(@"Did start synth %ld", SynthesizeSentence);
}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence{
    NSLog(@"Did finish synth, %ld", SynthesizeSentence);
    
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence{
    NSLog(@"Did start speak %ld", SpeakSentence);
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence{
    NSLog(@"Did end speak %ld", SpeakSentence);
    
}

- (void)synthesizerNewDataArrived:(NSData *)newData
                       DataFormat:(BDSAudioFormat)fmt
                   characterCount:(int)newLength
                   sentenceNumber:(NSInteger)SynthesizeSentence{
    NSLog(@"NewData arrive fmt: %d", fmt);
    
}

- (void)synthesizerTextSpeakLengthChanged:(int)newLength
                           sentenceNumber:(NSInteger)SpeakSentence{
    NSLog(@"SpeakLen %ld, %d", SpeakSentence, newLength);
    
}

- (void)synthesizerdidPause{
}

- (void)synthesizerResumed{
    NSLog(@"Did resume");
}

- (void)synthesizerCanceled{
    NSLog(@"Did cancel");
}

- (void)synthesizerErrorOccurred:(NSError *)error
                        speaking:(NSInteger)SpeakSentence
                    synthesizing:(NSInteger)SynthesizeSentence{
    NSLog(@"Did error %ld, %ld", SpeakSentence, SynthesizeSentence);
    
}




@end
