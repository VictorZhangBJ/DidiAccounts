//
//  BillsHeaderView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/22.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "BillsHeaderView.h"
#import "RootViewController/RootViewController.h"
@interface BillsHeaderView()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *scoresView;
@property (nonatomic, strong) UIView *dateView;

@end

@implementation BillsHeaderView

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
    self.dateView = [UIView new];
    self.dateView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.dateView];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@49);
        
    }];
    
    //dateLabel
    self.dateLabel = [UILabel new];
    self.dateLabel.textColor = [UIColor darkGrayColor];
    self.dateLabel.font = [UIFont systemFontOfSize:15];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.text = @"2016年9月";
    [self.dateView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dateView.mas_centerY);
        make.centerX.equalTo(self.dateView.mas_centerX).offset(-10);
        
    }];
    
    self.triangleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.triangleBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
    [self.dateView addSubview:self.triangleBtn];
    [self.triangleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 12));
        make.centerY.equalTo(self.dateView.mas_centerY);
        make.left.equalTo(self.dateLabel.mas_right).offset(5);
    }];
    
    
    //horizon line
    UIView *horizontalLine = [UIView new];
    horizontalLine.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    [self.dateView addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.left.equalTo(self.dateView.mas_left).offset(20);
        make.right.equalTo(self.dateView.mas_right).offset(-20);
        make.bottom.equalTo(self.dateView.mas_bottom).offset(-1);
    }];
    
    self.backgroundColor = [UIColor clearColor];
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.dateView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    //payView
    UIView *payView = [UIView new];
    [self.topView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left);
        make.top.equalTo(self.topView.mas_top);
        make.bottom.equalTo(self.topView.mas_bottom);
        make.width.mas_equalTo(self.topView.mas_width).multipliedBy(0.5);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_HEADERVIEW_VERTICAL_LINE;
    [self.topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(payView.mas_right);
        make.height.equalTo(self.topView.mas_height).multipliedBy(1.0 / 2.0);
    }];
    
    
    UILabel *payTitleLabel = [UILabel new];
    [payView addSubview: payTitleLabel];
    payTitleLabel.text = @"支出";
    payTitleLabel.font = [UIFont systemFontOfSize:12];
    payTitleLabel.textColor = [UIColor lightGrayColor];
    payTitleLabel.textAlignment = NSTextAlignmentLeft;
    [payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(payView.mas_centerX).offset(-20);
        
    }];
    
    self.payLabel = [UILabel new];
    self.payLabel.textColor = [UIColor darkGrayColor];
    self.payLabel.font = [UIFont systemFontOfSize:14];
    self.payLabel.textAlignment = NSTextAlignmentLeft;
    self.payLabel.text = @"19334.98";
    [payView addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payTitleLabel.mas_left);
        make.centerY.equalTo(payView.mas_centerY);
        make.top.equalTo(payTitleLabel.mas_bottom).offset(4);
    }];
    
    self.payPropertionLabel = [UILabel new];
    self.payPropertionLabel.textColor = [UIColor lightGrayColor];
    self.payPropertionLabel.font = [UIFont systemFontOfSize:12];
    self.payPropertionLabel.textAlignment = NSTextAlignmentLeft;
    self.payPropertionLabel.text = @"超过了40%的用户";
    [payView addSubview:self.payPropertionLabel];
    [self.payPropertionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payLabel.mas_left);
        make.top.equalTo(self.payLabel.mas_bottom).offset(4);
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
    incomeTitleLabel.textColor = [UIColor lightGrayColor];
    incomeTitleLabel.font = [UIFont systemFontOfSize:12];
    incomeTitleLabel.text = @"收入";
    [incomeView addSubview:incomeTitleLabel];
    [incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(incomeView.mas_centerX).offset(-20);
        
    }];
    
    self.incomeLabel = [UILabel new];
    self.incomeLabel.textColor = [UIColor darkGrayColor];
    self.incomeLabel.font = [UIFont systemFontOfSize:14];
    self.incomeLabel.textAlignment = NSTextAlignmentLeft;
    self.incomeLabel.text = @"18984.00";
    
    [incomeView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(incomeTitleLabel.mas_left);
        make.centerY.equalTo(incomeView.mas_centerY);
        make.top.equalTo(incomeTitleLabel.mas_bottom).offset(4);
    }];
    
 
    self.incomePropertionLabel = [UILabel new];
    self.incomePropertionLabel.textColor = [UIColor lightGrayColor];
    self.incomePropertionLabel.font = [UIFont systemFontOfSize:12];
    self.incomePropertionLabel.textAlignment = NSTextAlignmentLeft;
    self.incomePropertionLabel.text = @"超过了40%的用户";
    [payView addSubview:self.incomePropertionLabel];
    [self.incomePropertionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.incomeLabel.mas_left);
        make.top.equalTo(self.incomeLabel.mas_bottom).offset(4);
    }];

}


@end
