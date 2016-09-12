//
//  AppConfig.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/5.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+(UIColor *)navigationTintColor
{
    return [UIColor colorWithRed:1.00 green:0.29 blue:0.29 alpha:1.00];
}

+(UIColor *)headerLineColor
{
    //return [UIColor colorWithRed:0.53 green:0.54 blue:0.56 alpha:1.00];
    return [UIColor colorWithWhite:0.8 alpha:0.8];
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(NSArray *)gridViewButtonNameArray
{
    NSArray *btnNameArray = @[@"catering_H",@"clothes_H",@"home_H",@"traffic_H",@"shopping_H",
                              @"education_H",@"sport_H",@"relationship_H",@"health_H",@"finance_H",
                              @"other_H"];
    return btnNameArray;

}

+(NSArray *)gridViewBigButtonNameArray
{
    NSArray *btnNameArray = @[@"catering_B",@"clothes_B",@"home_B",@"traffic_B",@"shopping_B",
                              @"education_B",@"sport_B",@"relationship_B",@"health_B",@"finance_B",
                              @"other_B"];
    return btnNameArray;
    
}



+(NSArray *)giridViewLabelNameArray
{
    NSArray *labelNameArray = @[@"餐饮娱乐", @"服饰美容", @"居家物业", @"交通出行", @"购物",
                                @"教育培训", @"运动休闲", @"人情往来", @"医疗健康", @"财务管理",
                                @"其他"];
    return labelNameArray;
}


@end
