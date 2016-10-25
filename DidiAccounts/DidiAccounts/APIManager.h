//
//  APIManager.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/13.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiXinUser.h"

//服务器地址
#define HEADER_URL @"http://dev.shenxian.com:80"
//创建用户接口
#define CREATE_URL @"account-app/user/create.json"

//微信登录接口
#define WEIXIN_LOGIN_URL @"account-app/user/login.json"



@interface APIManager : NSObject

@property (nonatomic, copy) void(^CodeResponseBlock)(NSDictionary *codeDic);
@property (nonatomic, strong) WeiXinUser *user;


+(instancetype)sharedInstance;

//从微信获取code
-(void)getCodeFromWeChat:(void(^)(NSDictionary* codeDic)) codeResponseBlock;


//注册用户
-(void)createUser:(void(^)(BOOL isSuccess)) isSuccess;

//微信登录接口
-(void)registerUserWithWeiXinCode:(NSDictionary *)codeDic registerBlock:(void(^)(BOOL isSuccess)) registerBlock;


//生成接口URL
-(NSString *)generateURL:(NSString *)bodyURL;

-(WeiXinUser *)getUser;

-(void)setUser:(WeiXinUser *)user;

@end

