//
//  CategoryItem.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/9.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface CategoryItem : RLMObject

@property (nonatomic) NSInteger category_number;
@property (nonatomic) NSString* category_name;
@property (nonatomic) NSString* category_image_name;
@property (nonatomic) NSString* category_big_image_name;

@end
