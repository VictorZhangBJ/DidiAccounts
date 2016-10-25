//
//  WeiXinUser.m
//  DidiAccounts
//
//  Created by 张佳宾 on 10/25/16.
//  Copyright © 2016 victor. All rights reserved.
//

#import "WeiXinUser.h"

@implementation WeiXinUser

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.userMode forKey:@"userMode"];
    [aCoder encodeObject:self.points forKey:@"points"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.userMode = [aDecoder decodeObjectForKey:@"userMode"];
        self.points = [aDecoder decodeObjectForKey:@"points"];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
