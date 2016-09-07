//
//  MessageItem.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItem : NSObject

@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, assign) NSInteger categoryNumber;
@property (nonatomic, assign) NSInteger type;           //0 - 支出，1 - 收入
@property (nonatomic, assign) double amounts;          //支出 或 收入金额
@end
