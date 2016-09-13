//
//  MessageItem.m
//  DidiAccounts
//
//  Created by victor on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "MessageItem.h"

@implementation MessageItem
+(NSString *)primaryKey
{
    return @"message_id";
}

@end


@implementation User

+(NSString *)primaryKey
{
    return @"user_id";
}

@end