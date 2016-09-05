//
//  HeaderView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/5.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "HeaderView.h"
#import "AppConfig.h"
#import "RootViewController.h"

@interface HeaderView()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation HeaderView


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
    self.backgroundColor = [UIColor blueColor];
    self.topView = [UIView new];
    self.topView.backgroundColor = [AppConfig navigationTintColor];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(82);
    }];
    
    //payView
    UIView *payView = [UIView new];
    [self.topView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left);
        make.top.equalTo(self.topView.mas_top);
        make.bottom.equalTo(self.topView.mas_bottom);
        make.width.mas_equalTo(self.topView.mas_width).multipliedBy(0.46);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [AppConfig headerLineColor];
    [self.topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(payView.mas_right);
        make.height.equalTo(self.topView.mas_height).multipliedBy(1.0 / 2.0);
    }];
    
    
    UILabel *payTitleLabel = [UILabel new];
    [payView addSubview: payTitleLabel];
    payTitleLabel.text = @"本月支出";
    payTitleLabel.font = [UIFont systemFontOfSize:13];
    payTitleLabel.textColor = payLabel_color;
    payTitleLabel.textAlignment = NSTextAlignmentLeft;
    [payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(payView.mas_centerX);
        make.top.equalTo(line.mas_top);
        
    }];
    
    self.payLabel = [UILabel new];
    self.payLabel.textColor = [UIColor whiteColor];
    self.payLabel.font = [UIFont systemFontOfSize:15];
    self.payLabel.textAlignment = NSTextAlignmentLeft;
    self.payLabel.text = @"19334.98";
    [payView addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payTitleLabel.mas_left);
        //make.height.equalTo(@25);
        make.bottom.equalTo(line.mas_bottom);
        
    }];
    
    
    //incomeView
    
    UIView *incomeView = [UIView new];
    [self.topView addSubview:incomeView];
    [incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView.mas_right);
        make.top.equalTo(self.topView.mas_top);
        make.width.equalTo(payView.mas_width);
        make.bottom.equalTo(self.topView.mas_bottom);
    }];
    
    UILabel *incomeTitleLabel = [UILabel new];
    incomeTitleLabel.textAlignment = NSTextAlignmentLeft;
    incomeTitleLabel.textColor = payLabel_color;
    incomeTitleLabel.font = [UIFont systemFontOfSize:13];
    incomeTitleLabel.text = @"本月收入";
    [incomeView addSubview:incomeTitleLabel];
    [incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(incomeView.mas_centerX);
        make.top.equalTo(line.mas_top);
        
    }];
    
    self.incomeLabel = [UILabel new];
    self.incomeLabel.textColor = [UIColor whiteColor];
    self.incomeLabel.font = [UIFont systemFontOfSize:15];
    self.incomeLabel.textAlignment = NSTextAlignmentLeft;
    self.incomeLabel.text = @"18984.00";
    
    [incomeView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(incomeTitleLabel.mas_left);
        make.bottom.equalTo(line.mas_bottom);
    }];
    
    //detail button
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detailBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self.topView addSubview:self.detailBtn];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top);
        make.bottom.equalTo(self.topView.mas_bottom);
        make.right.equalTo(self.topView.mas_right);
        make.width.mas_equalTo(@60);
    }];
}

@end
