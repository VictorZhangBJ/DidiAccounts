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

#define trapezium_upperLine 116         //梯形上底
#define trapezium_lowerLine 92         //梯形下底
#define trapezium_height 24             //梯形高
#define right_trapezium_upperLine 134   //右边梯形上底

#define header_radius 22     //圆形半径                  

#define screen_width [UIScreen mainScreen].bounds.size.width    //屏幕宽度

#define tableViewBcakColor_1 [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00]
#define tableViewBackColor_2 [UIColor colorWithRed:0.89 green:0.91 blue:0.95 alpha:1.00]

#define tableHeader_height 50    //tableview header 高度

#define icon_red_color [UIColor colorWithRed:0.91 green:0.60 blue:0.60 alpha:1.00]
#define icon_green_color [UIColor colorWithRed:0.45 green:0.78 blue:0.76 alpha:1.00]

#define GridViewCell_backColor [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00]
#define PopViewSepratorLine_color [UIColor colorWithRed:0.88 green:0.89 blue:0.90 alpha:1.00]

@interface AppConfig : NSObject

//navigationBar tintColor
+(UIColor *)navigationTintColor;

+(UIColor *)headerLineColor;

+(UIImage*) createImageWithColor:(UIColor*) color;

+(NSArray *)gridViewButtonNameArray;

+(NSArray *)giridViewLabelNameArray;

+(NSArray *)gridViewBigButtonNameArray;

@end
