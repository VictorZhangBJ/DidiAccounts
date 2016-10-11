//
//  AppConfig.m
//  DidiAccounts
//
//  Created by victor on 16/9/5.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AppConfig.h"
#import "ModelManager.h"
#import "CategoryItem.h"

@implementation AppConfig
{
    RLMRealm *_realm;
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
    NSMutableArray *btnNameArray = [NSMutableArray new];
    RLMResults<CategoryItem *> *categorys = [self categorys];
    for(CategoryItem *item in categorys){
        [btnNameArray addObject:item.category_image_name];
    }
    return btnNameArray;
}

+(NSArray *)gridViewBigButtonNameArray
{
    NSMutableArray *btnBigNameArray = [NSMutableArray new];
    RLMResults<CategoryItem *> *categorys = [self categorys];
    for(CategoryItem *item in categorys){
        [btnBigNameArray addObject:item.category_big_image_name];
    }
    return btnBigNameArray;
    
}



+(NSArray *)giridViewLabelNameArray
{
    NSMutableArray *labelNameArray = [NSMutableArray new];
    RLMResults<CategoryItem *> *categorys = [self categorys];
    for(CategoryItem *item in categorys){
        [labelNameArray addObject:item.category_name];
    }
    return labelNameArray;
}

+(RLMResults<CategoryItem *> *)categorys
{
    RLMResults<CategoryItem *> *categorys = [CategoryItem allObjects];
    if (categorys.count == 0) {
        //创建
        CategoryItem *item1 = [[CategoryItem alloc] initWithValue:@[@0, @"餐饮娱乐", @"catering_H", @"catering_B"]];
        CategoryItem *item2 = [[CategoryItem alloc] initWithValue:@[@1, @"服饰美容", @"clothes_H", @"clothes_B"]];
        CategoryItem *item3 = [[CategoryItem alloc] initWithValue:@[@2, @"居家物业", @"home_H", @"home_B"]];
        CategoryItem *item4 = [[CategoryItem alloc] initWithValue:@[@3, @"交通出行", @"traffic_H", @"traffic_B"]];
        CategoryItem *item5 = [[CategoryItem alloc] initWithValue:@[@4, @"购物", @"shopping_H", @"shopping_B"]];
        CategoryItem *item6 = [[CategoryItem alloc] initWithValue:@[@5, @"教育培训", @"education_H", @"education_B"]];
        CategoryItem *item7 = [[CategoryItem alloc] initWithValue:@[@6, @"运动休闲", @"sport_H", @"sport_B"]];
        CategoryItem *item8 = [[CategoryItem alloc] initWithValue:@[@7, @"人情往来", @"relationship_H", @"relationship_B"]];
        CategoryItem *item9 = [[CategoryItem alloc] initWithValue:@[@8, @"医疗健康", @"health_H", @"health_B"]];
        CategoryItem *item10 = [[CategoryItem alloc] initWithValue:@[@9, @"财务管理", @"finance_H", @"finance_B"]];
        CategoryItem *item11 = [[CategoryItem alloc] initWithValue:@[@10, @"其他", @"other_H", @"other_B"]];
        
        [[[ModelManager sharedInstance] realm] beginWriteTransaction];
        [[[ModelManager sharedInstance] realm] addObject:item1];
        [[[ModelManager sharedInstance] realm] addObject:item2];
        [[[ModelManager sharedInstance] realm] addObject:item3];
        [[[ModelManager sharedInstance] realm] addObject:item4];
        [[[ModelManager sharedInstance] realm] addObject:item5];
        [[[ModelManager sharedInstance] realm] addObject:item6];
        [[[ModelManager sharedInstance] realm] addObject:item7];
        [[[ModelManager sharedInstance] realm] addObject:item8];
        [[[ModelManager sharedInstance] realm] addObject:item9];
        [[[ModelManager sharedInstance] realm] addObject:item10];
        [[[ModelManager sharedInstance] realm] addObject:item11];
        [[[ModelManager sharedInstance] realm] commitWriteTransaction];

        categorys = [CategoryItem allObjects];
        
    }else{
        
        
    }
    
    return categorys;
    
}

@end
