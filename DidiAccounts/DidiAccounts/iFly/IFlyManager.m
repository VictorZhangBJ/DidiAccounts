//
//  IFlyManager.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/1.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "IFlyManager.h"

@implementation IFlyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initIFlyRecognizer];
    }
    return self;
}


//启动听写
-(void)startListening
{
    self.result = @"";
    
    [_iFlySpeechRecognizer cancel];
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [_iFlySpeechRecognizer startListening];
    
    if (!ret) {
        NSLog(@"启动服务识别失败！");
    }else{
        NSLog(@"启动语言识别成功");
    }
    

}

//取消听写
-(void)cancelListening
{
    [_iFlySpeechRecognizer cancel];
}

//停止听写
-(void)stopListening
{
    [_iFlySpeechRecognizer stopListening];
}

-(void)initIFlyRecognizer
{
    
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
}

#pragma mark - IFlySpeechRecognizerDelegate

-(void)onError:(IFlySpeechError *)errorCode
{
    if (errorCode.errorCode !=0) {
        NSLog(@"识别错误 ： %d, %@",errorCode.errorCode, errorCode.errorDesc);
    }
}

-(void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    if (!self.result) {
        self.result = [NSString string];
    }
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    
    self.result = [self.result stringByAppendingString:resultFromJson];
    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
        _resultBlcok(self.result);
    }
//    NSLog(@"=====================================_result=%@",_result);
//    NSLog(@"=====================================resultFromJson=%@",resultFromJson);
//    NSLog(@"=====================================isLast=%d",isLast);
}

-(void)onBeginOfSpeech
{
    NSLog(@"语言听写开始");
}

-(void)onEndOfSpeech
{
    NSLog(@"语言听写结束");
}
@end
