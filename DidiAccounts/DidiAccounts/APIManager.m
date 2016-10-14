//
//  APIManager.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/13.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "APIManager.h"
#import "WXApi.h"
#import "AppConfig.h"

@implementation APIManager

static APIManager* _instance = nil;

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
        
    });
    return _instance;
}

/*
 *  我们要确保对象的唯一性，那么就需要阻止用户通过alloc、init 和 copy方法获取对象.创建对象分为 申请内存（alloc）和初始化（init）两步
 *  我们要确保对象的唯一性，第一步就要拦截他，调用alloc方法时，oc内部会调用allocWithZone方法来申请内存，我们复写这个这个方法，然后在这个方法中调用
 *  shareInstance 方法返回单例对象,就可以达到我们的目的，copy对象也是同样的道理，覆盖写copyWithZone方法
 */
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [APIManager sharedInstance];
}

-(void)getCodeFromWeChat:(void(^)(NSDictionary* codeDic)) codeResponseBlock
{
    self.CodeResponseBlock = codeResponseBlock;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(codeResponse:) name:NOTIFICATION_CODE_RESPONSE object:nil];
    
    SendAuthReq *req = [SendAuthReq new];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"shenxianyoucai";
    [WXApi sendReq:req];
}

-(void)codeResponse:(NSNotification *)noti
{
    NSDictionary *dic = (NSDictionary *)[noti object];
    self.CodeResponseBlock(dic);
}

@end
