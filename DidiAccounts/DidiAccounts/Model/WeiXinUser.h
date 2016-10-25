//
//  WeiXinUser.h
//  DidiAccounts
//
//  Created by 张佳宾 on 10/25/16.
//  Copyright © 2016 victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXinUser: NSObject<NSCoding>

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userMode;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *avatar;

@end;
