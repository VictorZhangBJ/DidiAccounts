//
//  AppConfig.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/5.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define payLabel_color [UIColor colorWithWhite: 0.85 alpha: 1.0]

@interface AppConfig : NSObject

//navigationBar tintColor
+(UIColor *)navigationTintColor;

+(UIColor *)headerLineColor;

+(UIImage*) createImageWithColor:(UIColor*) color;


@end
