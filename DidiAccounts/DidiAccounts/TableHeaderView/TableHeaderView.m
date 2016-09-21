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
#import "MessageItem.h"
#import "ModelManager.h"
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

-(void)configureViewWith:(NSInteger)section meesageArray:(NSArray *)messages;
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, TABLEVIEW_HEADER_HEIGHT);
    //绘制梯形
    CAShapeLayer *trapeziumLayer = [CAShapeLayer new];
    trapeziumLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, TABLEVIEW_HEADER_HEIGHT);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 30)];
    [bezierPath addLineToPoint:CGPointMake(11, 30)];
    [bezierPath addArcWithCenter:CGPointMake(11 + HEADER_RADIUS, 30) radius:HEADER_RADIUS startAngle:M_PI endAngle:M_PI_4 * 7 clockwise:YES];
    
    [bezierPath addLineToPoint:CGPointMake(11 + TRAPEZIUM_UPPER_LINE - 12, 15)];
    [bezierPath addLineToPoint:CGPointMake(11 + TRAPEZIUM_UPPER_LINE, 30)];
    
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH - RIGHT_TRAPEZIUM_UPPER_LINE - 11, 30)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH - RIGHT_TRAPEZIUM_UPPER_LINE - 11 + 15, 15)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH - 15 -11, 15)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH - 11, 30)];
    
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 30)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, TABLEVIEW_HEADER_HEIGHT)];
    [bezierPath addLineToPoint:CGPointMake(0, TABLEVIEW_HEADER_HEIGHT)];
    [bezierPath addLineToPoint:CGPointMake(0, TABLEVIEW_HEADER_HEIGHT)];
    
    if (section % 2 == 0) {
        self.backgroundColor = COLOR_SELF_TEXT_CELL_ODD_COLOR;
        trapeziumLayer.fillColor = COLOR_SELF_TEXT_CELL_EVEN_COLOR.CGColor;
    }else{
        self.backgroundColor = COLOR_SELF_TEXT_CELL_EVEN_COLOR;
        trapeziumLayer.fillColor = COLOR_SELF_TEXT_CELL_ODD_COLOR.CGColor;
    }
    trapeziumLayer.path = bezierPath.CGPath;
    
    
    [self.layer addSublayer:trapeziumLayer];
    
    //日历
    UIButton *calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [calenderBtn setImage:[UIImage imageNamed:@"calender"] forState:UIControlStateNormal];
    
    calenderBtn.frame = CGRectMake(11 + 6, 13, 32, 32);
    [self addSubview:calenderBtn];
    calenderBtn.backgroundColor = COLOR_ICON_RED;
    calenderBtn.layer.cornerRadius = 16;
    
    //日历 label
    self.calenderLabel = [UILabel new];
    self.calenderLabel.textColor = [UIColor lightGrayColor];
    self.calenderLabel.textAlignment = NSTextAlignmentCenter;
    self.calenderLabel.font = [UIFont systemFontOfSize:10];
    self.calenderLabel.text = @"09月05日";
    [self addSubview:self.calenderLabel];
    [self.calenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(calenderBtn.mas_right).offset(1);
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
        make.width.mas_equalTo(RIGHT_TRAPEZIUM_UPPER_LINE);
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
    
    //计算收入总和
    MessageItem *message = [messages firstObject];
    RLMResults<MessageItem *> *payResults = [MessageItem objectsWhere:@"dateString = %@ AND type == 0",message.dateString];
    double payAmounts = [[payResults sumOfProperty:@"amounts"] doubleValue];
    
    RLMResults<MessageItem *> *incomeResults = [MessageItem objectsWhere:@"dateString = %@ AND type == 1",message.dateString];
    double incomeAmounts = [[incomeResults sumOfProperty:@"amounts"] doubleValue];
    
    double totalNumber = incomeAmounts - payAmounts;
    if (totalNumber >= 0) {
        self.totalLabel.text = [NSString stringWithFormat:@"+%.2f",totalNumber];
    }else{
        self.totalLabel.text = [NSString stringWithFormat:@"%.2f",totalNumber];
    }
    self.calenderLabel.text = message.dateString;
    
}

@end
