//
//  VoiceView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/20.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "VoiceView.h"
#import "RootViewController.h"

@interface VoiceView ()

@property (nonatomic, strong)UIImageView* volumeImageView;
@property (nonatomic, strong)UIImageView *micImageView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *cancelImageView;

@end

@implementation VoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView
{
    self.backgroundColor = [UIColor colorWithRed:0.52 green:0.53 blue:0.58 alpha:0.5];
    self.layer.cornerRadius = 7.0;
    _micImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone"]];
    [self addSubview:_micImageView];
    [_micImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 65));
        make.left.equalTo(self.mas_left).offset(40);
        make.top.equalTo(self.mas_top).offset(30);
    }];
    
    self.label = [UILabel new];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.text = @"手指上滑,取消发送";
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    self.volumeImageView = [[UIImageView alloc]init];
    [self addSubview:self.volumeImageView];
    [self.volumeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_micImageView.mas_right).offset(12);
        make.bottom.equalTo(_micImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(21, 44));
    }];
    
    self.cancelImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cancel"]];
    [self addSubview:self.cancelImageView];
    [self.cancelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 70));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(30);
    }];
    self.cancelImageView.hidden = YES;
}
-(void)volumeDidChange:(NSInteger)volume
{
    if (volume !=0) {
        self.volumeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"volume_%ld",volume - 1]];
    }else{
        self.volumeImageView.image = nil;
    }
}
-(void)speechBtnTouchUpOutside
{
    
}
-(void)cancelRecord
{
    self.micImageView.hidden = YES;
    self.volumeImageView.hidden = YES;
    self.cancelImageView.hidden = NO;
    self.label.backgroundColor = [UIColor colorWithRed:0.81 green:0.36 blue:0.36 alpha:0.6];
    self.label.layer.masksToBounds = YES;
    
    self.label.layer.cornerRadius = 2.0;
}

@end
