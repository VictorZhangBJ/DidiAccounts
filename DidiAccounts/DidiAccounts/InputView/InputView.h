//
//  InputView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/31.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol InputViewDelegate <NSObject>

-(void)rightBtnClick;

-(void)endRecord;

-(void)startRecord;

@end

@interface InputView : UIView<AVAudioRecorderDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *speechButton;
@property (nonatomic) BOOL isInputTextMode;
@property (nonatomic, weak) id<InputViewDelegate> delegate;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL* audioPlayURL;
@end
