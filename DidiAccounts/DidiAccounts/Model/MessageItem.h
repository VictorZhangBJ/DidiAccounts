//
//  MessageItem.h
//  DidiAccounts
//
//  Created by victor on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class User;
@interface MessageItem : RLMObject

@property  NSDate *message_create_date;
@property  NSString *content;
@property  NSString *category_name;
@property  NSString *dateString;
@property  NSInteger category_number;
@property  NSInteger type;           //0 - 支出，1 - 收入
@property  double amounts;          //支出 或 收入金额
@property  NSInteger message_id;    //primary key 自增
@property User *owner;
@property NSInteger month;

-(NSInteger)dateToMonth:(NSDate *)date;
-(NSString *)dateToString:(NSDate *)date;
-(void)setDate:(NSDate*)date;
@end
RLM_ARRAY_TYPE(MessageItem)


@interface User : RLMObject

@property NSDate *user_create_date;
@property NSInteger user_id;
@property NSString *user_name;

@end