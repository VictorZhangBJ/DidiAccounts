//
//  InputView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/31.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "InputView.h"
#import "RootViewController.h"
#import "Math.h"
@interface InputView()

@end

@implementation InputView
{
    NSTimer* _timer;
    IFlyManager* _iFlyManager;
    NSInteger _volume;
    BOOL _isCanceled;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    self = [super init];
    [self configureInputView];
    [self configureIFlyManager];
    return self;
}

-(void)configureIFlyManager
{
    _iFlyManager = [[IFlyManager alloc]init];
    _iFlyManager.delegate = self;
    
}

#pragma mark - IFlyManagerDelegate
-(void)endListengingWithString:(NSString *)resultString
{
    NSLog(@"回调 resultString = %@",resultString);
    if ([_delegate respondsToSelector:@selector(didSendVoiceString:)]) {
        [_delegate didSendVoiceString:resultString];
    }
}

-(void)volumeDidChange:(NSInteger)volume
{
    NSInteger newVolume = round(volume / 4.285);
    if (newVolume >= 7) {
        newVolume = 7;
    }
    [_delegate volumeDidChange:newVolume];
}

-(void)configureInputView
{
    self.isInputTextMode = YES;
    self.inputViewType = InputViewTypePay;    //默认支出模式
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00];
    
    self.textField = [UITextField new];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.textField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.delegate = self;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@38);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(50);
    }];
    
    //语言输入按钮，长按说话
    self.speechButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.speechButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    self.speechButton.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00];
    [self.speechButton addTarget:self action:@selector(speechBtnTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.speechButton addTarget:self action:@selector(speechBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.speechButton addTarget:self action:@selector(speechBtnTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [self.speechButton addTarget:self action:@selector(speechBtnTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    
    UIColor *borderColor = [UIColor colorWithRed:0.72 green:0.73 blue:0.75 alpha:1.00];
    self.speechButton.layer.borderColor = borderColor.CGColor;
    self.speechButton.layer.borderWidth = 0.5f;
    self.speechButton.layer.cornerRadius = 6.0f;
    [self.speechButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.speechButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.textField addSubview:self.speechButton];
    [self.speechButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.textField);
    }];
    self.speechButton.hidden = YES;
    
    //左边按钮，包含语言和文字输入切换
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setImage:[UIImage imageNamed:@"inputVoice"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"inputVoiceHL"] forState:UIControlStateHighlighted];
    self.leftButton.adjustsImageWhenHighlighted = YES;
    [self addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@50);
        make.height.equalTo(@40);
        make.left.equalTo(self.mas_left);
    }];
    
    //右边按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:[UIImage imageNamed:@"payBtn"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right);
        
    }];
}

//发送键按下
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return 按下");
    if ([_delegate respondsToSelector:@selector(returnKeyClick)]) {
        [_delegate returnKeyClick];
    }
    return true;
}
-(void)leftBtnClick
{
    if (self.isInputTextMode) {
        //切换成语言输入
        [self.leftButton setImage:[UIImage imageNamed:@"inputText"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"inputTextHL"] forState:UIControlStateHighlighted];
        self.speechButton.hidden = NO;
        [self.textField resignFirstResponder];
        
    }else{
        [self.leftButton setImage:[UIImage imageNamed:@"inputVoice"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"inputVoiceHL"] forState:UIControlStateHighlighted];
        self.speechButton.hidden = YES;
        [self.textField becomeFirstResponder];
    }
    
    self.isInputTextMode = !self.isInputTextMode;
}

-(void)rightBtnClick
{
    NSLog(@"改变右边按钮");
    //改变右边按钮的图片
    if (self.inputViewType == InputViewTypePay) {
        [self.rightButton setImage:[UIImage imageNamed:@"incomeBtn"] forState:UIControlStateNormal];
        self.inputViewType = InputViewTypeIncome;
    }else{
        [self.rightButton setImage:[UIImage imageNamed:@"payBtn"] forState:UIControlStateNormal];
        self.inputViewType = InputViewTypePay;
    }
}

-(void)speechBtnTouchDown
{
    NSLog(@"录音按下");
    [self startAudio];
    [_iFlyManager startListening];
    [[[SlideMenuViewController sharedInstance] pan] setEnabled:NO];
    if ([_delegate respondsToSelector:@selector(startRecord)]) {
        [_delegate startRecord];
    }
    _isCanceled = NO;
}

-(void)speechBtnTouchUpInside
{
    NSLog(@"录音结束");
    [self endAudio];
    
    [_iFlyManager stopListening];
    [[[SlideMenuViewController sharedInstance] pan] setEnabled:YES];

    if ([_delegate respondsToSelector:@selector(endRecord)]) {
        [_delegate endRecord];
    }
    _isCanceled = NO;
}

-(void)speechBtnTouchDragExit
{
    NSLog(@"录音取消");
    _isCanceled = YES;
    [self endAudio];
    [_iFlyManager cancelListening];
    [[[SlideMenuViewController sharedInstance] pan] setEnabled:YES];
    if ([_delegate respondsToSelector:@selector(cancelRecord)]) {
        [_delegate cancelRecord];
    }
}

-(void)speechBtnTouchUpOutside
{
    NSLog(@"手松开");
    if (_isCanceled) {
        [_delegate speechBtnTouchUpOutside];
    }
}

-(void)startAudio
{
    //[self.speechButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.speechButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.speechButton setTitle:@"松开 结束" forState:UIControlStateNormal];

}

-(void)endAudio
{
    [self.speechButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    self.speechButton.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00];
}

@end
