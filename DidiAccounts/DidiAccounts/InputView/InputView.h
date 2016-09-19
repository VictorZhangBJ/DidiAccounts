//
//  InputView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/31.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IFlyManager.h"
#import "SlideMenuViewController.h"


typedef NS_ENUM(NSInteger, InputViewType){
    InputViewTypePay,
    InputViewTypeIncome
};


@protocol InputViewDelegate <NSObject>

-(void)endRecord;

-(void)startRecord;

-(void)returnKeyClick;

-(void)didSendVoiceString:(NSString *)voiceString;

@end

@interface InputView : UIView<AVAudioRecorderDelegate, UITextFieldDelegate, IFlyManagerDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *speechButton;
@property (nonatomic) BOOL isInputTextMode;
@property (nonatomic, weak) id<InputViewDelegate> delegate;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL* audioPlayURL;

@property (nonatomic) InputViewType inputViewType;     //支出还是 收入模式

@end
