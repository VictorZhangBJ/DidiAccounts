//
//  TableHeaderView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "TableHeaderView.h"
#import "AppConfig.h"
#import "RootViewController.h"
@implementation TableHeaderView

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
    }
    return self;
}

-(void)configureViewWith:(NSInteger)section;
{
    self.frame = CGRectMake(0, 0, screen_width, tableHeader_height);
    //绘制梯形
    CAShapeLayer *trapeziumLayer = [CAShapeLayer new];
    trapeziumLayer.frame = CGRectMake(0, 0, screen_width, tableHeader_height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 30)];
    [bezierPath addLineToPoint:CGPointMake(11, 30)];
    [bezierPath addArcWithCenter:CGPointMake(11 + header_radius, 30) radius:header_radius startAngle:M_PI endAngle:M_PI_4 * 7 clockwise:YES];
    
    [bezierPath addLineToPoint:CGPointMake(11 + trapezium_upperLine - 12, 15)];
    [bezierPath addLineToPoint:CGPointMake(11 + trapezium_upperLine, 30)];
    
    [bezierPath addLineToPoint:CGPointMake(screen_width - right_trapezium_upperLine - 11, 30)];
    [bezierPath addLineToPoint:CGPointMake(screen_width - right_trapezium_upperLine - 11 + 15, 15)];
    [bezierPath addLineToPoint:CGPointMake(screen_width - 15 -11, 15)];
    [bezierPath addLineToPoint:CGPointMake(screen_width - 11, 30)];
    
    [bezierPath addLineToPoint:CGPointMake(screen_width, 30)];
    [bezierPath addLineToPoint:CGPointMake(screen_width, tableHeader_height)];
    [bezierPath addLineToPoint:CGPointMake(0, tableHeader_height)];
    [bezierPath addLineToPoint:CGPointMake(0, tableHeader_height)];
    
    if (section % 2 == 0) {
        self.backgroundColor = tableViewBcakColor_1;
        trapeziumLayer.fillColor = tableViewBackColor_2.CGColor;
    }else{
        self.backgroundColor = tableViewBackColor_2;
        trapeziumLayer.fillColor = tableViewBcakColor_1.CGColor;
    }
    trapeziumLayer.path = bezierPath.CGPath;
    
    
    [self.layer addSublayer:trapeziumLayer];
    
    //日历
    UIButton *calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [calenderBtn setImage:[UIImage imageNamed:@"calender"] forState:UIControlStateNormal];
    
    calenderBtn.frame = CGRectMake(11 + 6, 13, 32, 32);
    [self addSubview:calenderBtn];
    calenderBtn.backgroundColor = icon_red_color;
    calenderBtn.layer.cornerRadius = 16;
    
    //日历 label
    self.calenderLabel = [UILabel new];
    self.calenderLabel.textColor = [UIColor lightGrayColor];
    self.calenderLabel.textAlignment = NSTextAlignmentCenter;
    self.calenderLabel.font = [UIFont systemFontOfSize:12];
    self.calenderLabel.text = @"09月05日";
    [self addSubview:self.calenderLabel];
    [self.calenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(calenderBtn.mas_right).offset(3);
        make.centerY.equalTo(calenderBtn.mas_centerY).offset(-3);
        make.width.equalTo(@70);
    }];
    
    
    //合计view
    UIView *totalView = [UIView new];
    [self addSubview:totalView];
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right).offset(-11);
        make.width.mas_equalTo(right_trapezium_upperLine);
    }];
    
    UIView *spaceOne = [UIView new];
    UIView *spaceTwo = [UIView new];
    [totalView addSubview:spaceOne];
    [totalView addSubview:spaceTwo];
    
    [spaceOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalView.mas_centerY);
        make.left.equalTo(totalView.mas_left);
        make.width.greaterThanOrEqualTo(@8);
    }];
    
    UIButton *pigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pigBtn setImage:[UIImage imageNamed:@"pig_red"] forState:UIControlStateNormal];
    [totalView addSubview:pigBtn];
    [pigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(spaceOne.mas_right);
        make.centerY.equalTo(totalView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(11, 11));
        
    }];
    
    self.totalLabel = [UILabel new];
    self.totalLabel.textColor = [UIColor lightGrayColor];
    self.totalLabel.font = [UIFont systemFontOfSize:12];
    self.totalLabel.textAlignment = NSTextAlignmentLeft;
    self.totalLabel.text = @"+114,23.00";
    [totalView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pigBtn.mas_right).offset(5);
        make.centerY.equalTo(totalView.mas_centerY);
    }];
    
    [spaceTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalLabel.mas_right);
        make.centerY.equalTo(totalView.mas_centerY);
        make.width.equalTo(spaceOne.mas_width);
        make.right.equalTo(totalView.mas_right);
    }];
    
    
    
    
}

@end
