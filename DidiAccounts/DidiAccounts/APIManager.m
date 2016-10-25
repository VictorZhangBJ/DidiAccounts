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
#import <AFNetworking/AFNetworking.h>
#import "Model/ModelManager.h"

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

-(void)getAccessTokenWithCode:(NSString *)code
{
    NSString *AppID = @"wx50a2226f3e8b59a9";
    NSString *AppSecret = @"95fc1d6cb5f59b141b7a7ae404d70388";
    NSString *access_token_url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",AppID,AppSecret,code];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain" ,nil]];
    
    
    NSError *error = NULL;
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET"
                                                              URLString:access_token_url
                                                             parameters:nil
                                                                  error:&error];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"微信获取access_token失败，error = %@",error.description);
            
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"微信获取access_token成功 = %@",dic);
            [self getUserInfoWithAccessToken:[dic objectForKey:@"access_token"] openId:[dic objectForKey:@"openid"]];
            
        }
    }];
    [task resume];
    
    
}


-(void)getUserInfoWithAccessToken:(NSString *)access_token openId:(NSString *)openId
{
    NSString *userinfo_url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain" ,nil]];
    
    
    NSError *error = NULL;
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET"
                                                              URLString:userinfo_url
                                                             parameters:nil
                                                                  error:&error];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"微信获取userinfo失败，error = %@",error.description);
            
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"微信获取userinfo成功 = %@",dic);
            [[ModelManager sharedInstance].realm beginWriteTransaction];
            [User createOrUpdateInRealm:[ModelManager sharedInstance].realm withValue:@{@"user_id": @"1",
                                                                                        @"nick_name": [dic objectForKey:@"nickname"],
                                                                                        @"avatar": [dic objectForKey:@"headimgurl"],
                                                                                        @"isLogin": @"1"}];
            
            [[ModelManager sharedInstance].realm commitWriteTransaction];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];
        }
    }];
    [task resume];

    
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
    [self getAccessTokenWithCode:[dic objectForKey:@"code"]];
}

-(void)registerUserWithWeiXinCode:(NSDictionary *)codeDic registerBlock:(void(^)(BOOL isSuccess)) registerBlock
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html" ,nil]];

    
    NSError *error = NULL;
    
    NSDictionary *parameter = @{@"uid": [ModelManager sharedInstance].user.user_id,
                                @"token": [ModelManager sharedInstance].user.token,
                                @"code": [codeDic objectForKey:@"code"]};
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"POST"
                                                              URLString:[self generateURL:WEIXIN_LOGIN_URL]
                                                             parameters:parameter
                                                                  error:&error];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"微信获取code失败，error = %@",error.description);
            registerBlock(NO);
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"微信获取code成功 = %@",dic);
            registerBlock(YES);
        }
    }];
    [task resume];
}

//注册用户
-(void)createUser:(void(^)(BOOL isSuccess)) isSuccess
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html" ,nil]];
    manager.responseSerializer = responseSerializer;
    

    NSError *error = NULL;
    NSString *user_id = [ModelManager sharedInstance].user.user_id;
    NSString *token = [ModelManager sharedInstance].user.token;
    NSDictionary *dic = @{@"id":user_id, @"token": token};
    NSString *paraString =[self DataTOjsonString:dic];
    NSDictionary *parameter = @{@"user": paraString};

    
    
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"POST"
                                                              URLString:[self generateURL:CREATE_URL]
                                                             parameters:parameter
                                                                  error:&error];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"创建用户失败，error = %@",error.description);
            isSuccess(NO);
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"creat user dic = %@",dic);
            ModelManager *modelManager = [ModelManager sharedInstance];
            [modelManager.realm beginWriteTransaction];
            [User createOrUpdateInRealm:modelManager.realm withValue:@{@"user_id": dic[@"id"],
                                                                       @"token": dic[@"token"],
                                                                       @"userMode": dic[@"userMode"]}];
            
            [modelManager.realm commitWriteTransaction];
            isSuccess(YES);
        }
    }];
    [task resume];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

-(NSString *)generateURL:(NSString *)bodyURL
{
    return [HEADER_URL stringByAppendingPathComponent:bodyURL];
}

-(NSString *)UUID
{
    NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    if (UUID == nil) {
        UUID = [NSUUID UUID].UUIDString;
        [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:@"UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return UUID;
}

@end


