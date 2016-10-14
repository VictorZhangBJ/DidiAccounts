//
//  APIManager.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/13.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

@property (nonatomic, copy) void(^CodeResponseBlock)(NSDictionary *codeDic);

+(instancetype)sharedInstance;

//从微信获取code
-(void)getCodeFromWeChat:(void(^)(NSDictionary* codeDic)) codeResponseBlock;

@end
