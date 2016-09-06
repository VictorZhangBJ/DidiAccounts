//
//  TableHeaderView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "TableHeaderView.h"
#import "AppConfig.h"

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
    
}

@end
