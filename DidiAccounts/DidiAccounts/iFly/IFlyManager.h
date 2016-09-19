//
//  IFlyManager.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/1.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iflyMSC/iflyMSC.h>
#import "IATConfig.h"
#import "ISRDataHelper.h"

@protocol IFlyManagerDelegate <NSObject>

-(void)endListengingWithString:(NSString *)resultString;

@end

@interface IFlyManager : NSObject<IFlySpeechRecognizerDelegate>

@property (nonatomic, strong) NSString *pcmFilePath;    //音频文件路径
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;       //不带界面的语音识别对象
@property (nonatomic, strong) NSString *result;
@property (nonatomic, assign) id<IFlyManagerDelegate> delegate;

//启动听写
-(void)startListening;

//取消听写
-(void)cancelListening;

//停止听写
-(void)stopListening;

@end
