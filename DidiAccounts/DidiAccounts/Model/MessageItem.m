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

-(NSInteger)dateToMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    return month;
}

-(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

-(void)setDate:(NSDate*)date
{
    self.message_create_date = date;
    self.month = [self dateToMonth:date];
    self.dateString = [self dateToString:date];
}

@end


@implementation User

+(NSString *)primaryKey
{
    return @"user_id";
}

@end