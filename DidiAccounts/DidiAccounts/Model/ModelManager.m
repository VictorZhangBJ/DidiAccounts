//
//  ModelManager.m
//  DidiAccounts
//
//  Created by victor on 16/9/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ModelManager.h"

@interface ModelManager ()

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) User *user;

@end

@implementation ModelManager


static ModelManager* _instance = nil;

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
        [_instance configureRealm];
    });
    return _instance;
}

-(void)configureRealm
{
    self.realm = [RLMRealm defaultRealm];
    RLMResults<User *>  *results = [User allObjects];
    if (results.count == 0) {
        NSLog(@"不存在user用户，创建一个");
        self.user = [[User alloc]init];
        self.user.user_name = @"victor_test";
        self.user.user_create_date = [NSDate date];
        self.user.user_id = 1;
        self.user.messages = nil;
        [self.realm beginWriteTransaction];
        [self.realm addObject:self.user];
        [self.realm commitWriteTransaction];
    }else{
        NSLog(@"存在user用户");
        self.user = [results firstObject];
    }
}

-(MessageItem *)parseStringToMessage:(NSString *)inputText
{
    NSLog(@"inputText = %@",inputText);
  
    NSString *searchStr = [[NSString alloc]initWithString:inputText];
    
    NSString *regexStr = @"([0]|([1-9][0-9]*))([.][0-9]+)?";
    
    //正则表达式类
    NSError *error = NULL;
    //整数或者小数
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchStr options:0 range:NSMakeRange(0, searchStr.length)];
    if (result) {
        NSLog(@"reusultString = %@",[searchStr substringWithRange:result.range]);
    }else{
        NSLog(@"没有找到符合要求的子串");
    }
    
    //解析文字
    NSMutableString *mutableStr = [NSMutableString stringWithString:searchStr];
    [mutableStr deleteCharactersInRange:result.range];
    [mutableStr replaceOccurrencesOfString:@"块" withString:@"" options:1 range:NSMakeRange(0, mutableStr.length)];
    [mutableStr replaceOccurrencesOfString:@"元" withString:@"" options:1 range:NSMakeRange(0, mutableStr.length)];
    

    return nil;
}


@end
