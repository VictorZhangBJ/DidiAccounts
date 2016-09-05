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
@end
