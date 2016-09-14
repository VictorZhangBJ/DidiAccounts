//
//  ModelManager.m
//  DidiAccounts
//
//  Created by victor on 16/9/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ModelManager.h"
#import "AppConfig.h"

@interface ModelManager ()



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

-(MessageItem *)parseStringToMessage:(NSString *)inputText withType:(NSInteger)type;
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
    
    NSString *amountsString = nil;
    NSTextCheckingResult *result = [regex firstMatchInString:searchStr options:0 range:NSMakeRange(0, searchStr.length)];
    if (result) {
        amountsString =[searchStr substringWithRange:result.range];
        NSLog(@"reusultString = %@",amountsString);
    }else{
        NSLog(@"没有找到符合要求的子串");
    }
    
    //解析文字
    NSString *contentString = nil;
    if (result) {
        contentString = [searchStr stringByReplacingOccurrencesOfString:amountsString withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchStr.length)];
    }else{
        contentString = searchStr;
    }

    
    //解析类别
    NSDictionary *categoryDic =[self readJson];
    NSString *category_name = nil;
    
    BOOL isInCategoryDic = NO;
    for(NSString *action in categoryDic.allKeys){
        if ([contentString containsString:action]) {
            NSLog(@"%@ 属于 %@ 类别",contentString,[categoryDic objectForKey: action]);
            NSLog(@"key = %@", action);
            isInCategoryDic = YES;
            category_name = [categoryDic objectForKey:action];
            break;
        }
    }
    
    if (isInCategoryDic == NO) {
        NSLog(@"%@ 属于 其他", contentString);
        category_name = @"其他";
    }
    
    MessageItem *message = [[MessageItem alloc]init];
    message.message_create_date = [NSDate date];
    message.category_name = category_name;
    message.category_number = [[AppConfig giridViewLabelNameArray] indexOfObject:category_name];
    message.content = contentString;
    message.amounts = [amountsString doubleValue];
    message.message_id = [message.message_create_date timeIntervalSince1970];
    message.type = type;
    NSLog(@"messageId = %ld",message.message_id);
    
//    [self.realm beginWriteTransaction];
//    [self.user.messages addObject:message];
//    [self.realm commitWriteTransaction];
//    
//    NSLog(@"messges count = %lu",self.user.messages.count);
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_INSERT_MESSAGE object:nil];
    
    return message;
}

//读取json文件
-(NSDictionary *)readJson
{
    NSDictionary *categoryDic = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"categoryDic"] == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            NSLog(@"json parse error = %@",error.description);
        }
        NSDictionary *categoryListArray = [jsonDic objectForKey:@"categoryList"];
        for(NSDictionary *dic in categoryListArray){
            NSString *action = [dic objectForKey:@"action"];
            NSString *categoryName = [dic objectForKey:@"categoryName"];
            
            [tempDic setObject:categoryName forKey:action];
            
        }
        categoryDic = tempDic;
        [ud setObject:categoryDic forKey:@"categoryDic"];
        [ud synchronize];
        NSLog(@"cateroy.json 不在缓存");
    }else{
        categoryDic = [ud objectForKey:@"categoryDic"];
    }
    
    
//    for(NSString *key in [categoryDic allKeys]){
//        NSString *object = [categoryDic objectForKey:key];
//        NSLog(@"%@: %@",key, object);
//    }
    return categoryDic;
    
}

@end
