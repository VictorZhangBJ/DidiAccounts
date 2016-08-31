//
//  InputView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/31.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "InputView.h"
#import "RootViewController.h"

@implementation InputView

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
    return self;
}

-(void)configureInputView
{
    self.isInputTextMode = YES;
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00];
    self.textField = [UITextField new];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.textField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(50);
    }];
    
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
    
    //文字按钮
    UIButton *textInputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [textInputBtn setTitle:@"文字" forState:UIControlStateNormal];
    [textInputBtn addTarget:self action:@selector(textInputBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:textInputBtn];
    [textInputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right);
        
    }];
    
}

-(void)leftBtnClick
{
    if (self.isInputTextMode) {
        //切换成语言输入
        [self.leftButton setImage:[UIImage imageNamed:@"inputText"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"inputTextHL"] forState:UIControlStateHighlighted];
    }else{
        [self.leftButton setImage:[UIImage imageNamed:@"inputVoice"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"inputVoiceHL"] forState:UIControlStateHighlighted];
    }
    
    self.isInputTextMode = !self.isInputTextMode;
}

-(void)textInputBtnClick
{
    
}
@end
