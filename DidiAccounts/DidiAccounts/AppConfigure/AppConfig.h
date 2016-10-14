//
//  AppConfig.h
//  DidiAccounts
//
//  Created by victor on 16/9/5.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COLOR_NAVIGATION_BAR [UIColor colorWithRed:0.93 green:0.31 blue:0.33 alpha:1.00]
#define COLOR_HEADERVIEW_VERTICAL_LINE [UIColor colorWithWhite:0.8 alpha:0.8]
#define COLOR_HEADERVIEW_PAY_LABEL [UIColor colorWithWhite: 0.95 alpha: 1.0]
#define COLOR_ICON_RED [UIColor colorWithRed:0.91 green:0.60 blue:0.60 alpha:1.00]
#define COLOR_ICON_GREEN [UIColor colorWithRed:0.45 green:0.78 blue:0.76 alpha:1.00]
#define COLOR_SELF_TEXT_CELL_ODD_COLOR [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00]
#define COLOR_SELF_TEXT_CELL_EVEN_COLOR [UIColor colorWithRed:0.89 green:0.91 blue:0.95 alpha:1.00]
#define COLOR_GRIDVIEW_CELL [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00]
#define COLOR_POPVIEW_SEPARATOR_LINE [UIColor colorWithRed:0.88 green:0.89 blue:0.90 alpha:1.00]
#define COLOR_LEFTVIEW_BACKGROUND [UIColor colorWithRed:0.16 green:0.18 blue:0.24 alpha:1.00]
#define COLOR_LEFTVIEW_CELL_SELECTED [UIColor colorWithRed:0.11 green:0.12 blue:0.20 alpha:1.00]
#define COLOR_ADVICEVIEW_BACKGROUND [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00]
#define COLOR_SETTINGVIEW_CELL_SEPARATOR [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width  
#define LEFTVIEW_SCALE 2.0/3.0

#define TRAPEZIUM_UPPER_LINE 116         //梯形上底
#define TRAPEZIUM_LOWER_LINE 92         //梯形下底
#define TRAPEZIUM_HEIGHT 24             //梯形高
#define RIGHT_TRAPEZIUM_UPPER_LINE 134   //右边梯形上底
#define HEADER_RADIUS 22     //圆形半径
#define TABLEVIEW_HEADER_HEIGHT 50    //tableview header 高度

#define NOTIFICATION_INSERT_MESSAGE @"NOTIFICATION_INSERT_MESSAGE"
#define NOTIFICATION_SHOW_LEFTVIEW @"NOTIFICATION_SHOW_LEFTVIEW"
#define NOTIFICATION_CODE_RESPONSE @"NOTIFICATION_CODE_RESPONSE"

@interface AppConfig : NSObject

+(UIImage*) createImageWithColor:(UIColor*) color;

+(NSArray *)gridViewButtonNameArray;

+(NSArray *)giridViewLabelNameArray;

+(NSArray *)gridViewBigButtonNameArray;

@end
