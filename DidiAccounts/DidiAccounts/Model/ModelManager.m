//
//  ModelManager.m
//  DidiAccounts
//
//  Created by victor on 16/9/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ModelManager.h"
#import "AppConfig.h"
#import "Math.h"

@interface ModelManager ()
{
    NSString *_contentString;
}
@property (nonatomic, strong) NSDictionary *numberDict;

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
    self.numberDict = @{@"一": @"1",
                        @"二": @"2",
                        @"三": @"3",
                        @"四": @"4",
                        @"五": @"5",
                        @"六": @"6",
                        @"七": @"7",
                        @"八": @"8",
                        @"九": @"9",
                        @"两": @"2",
                        @"十": @"10"};
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
    NSString *searchStr = [[NSString alloc]initWithString:inputText];
    
    NSString *regexStr = @"([0]|([1-9][0-9]*))([.][0-9]+)?";
    NSString *ignoreRegex = [NSString stringWithFormat:@"%@[元]",regexStr];
    
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
        NSLog(@"reusultString ======= %@",amountsString);
        
    }else{
        NSLog(@"没有找到符合要求的子串");
    }
    
    //解析文字
    NSString *contentString = nil;
    if (result) {
        contentString = [searchStr stringByReplacingOccurrencesOfString:amountsString withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchStr.length)];
        
        NSRange range2 = [inputText rangeOfString:ignoreRegex options:NSRegularExpressionSearch];
        if (range2.location != NSNotFound) {
            NSString *subString = [inputText substringWithRange:range2];
            [contentString stringByReplacingOccurrencesOfString:subString withString:amountsString];
        }
        
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
    
    return message;
}


//解析语言输入文字
-(MessageItem *)parseVoiceStringToMessage:(NSString *)inputText withType:(NSInteger)type
{
    NSLog(@"voiceInputText = %@",inputText);
    
   
    NSString *intString = @"";
    NSString *maoString = @"";
    NSString *fenString = @"";
    
    NSString *contentString = @"";
    _contentString = @"";
    
    NSRange range = [inputText rangeOfString:@"[0-9]+[块]" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSString *subString = [inputText substringWithRange:range];
        intString = [subString stringByReplacingOccurrencesOfString:@"块" withString:@""];
        contentString = [inputText stringByReplacingOccurrencesOfString:subString withString:@""];
        
        
        NSRange range2 = [inputText rangeOfString:@"[0-9]+[块][0-9]" options:NSRegularExpressionSearch];
        if (range2.location != NSNotFound) {
            NSString *subString1 = [inputText substringWithRange:range2];
            
            maoString = [subString1 substringFromIndex:range2.length -1];
            NSLog(@"毛string = %@",maoString);
            intString = [NSString stringWithFormat:@"%@.%@",intString,maoString];
            
            contentString = [inputText stringByReplacingOccurrencesOfString:[inputText substringWithRange:range2] withString:@""];
            NSRange range3 = [inputText rangeOfString:@"[0-9]+[块][0-9][毛][0-9][分]" options:NSRegularExpressionSearch];
            if (range3.location != NSNotFound) {
                fenString = [[inputText substringWithRange:range3] substringWithRange:NSMakeRange(range3.length - 2, 1)];
                NSLog(@"分String = %@",fenString);
                intString = [NSString stringWithFormat:@"%@%@",intString,fenString];
                contentString = [inputText stringByReplacingOccurrencesOfString:[inputText substringWithRange:range3] withString:@""];
                
            }
        }
    }else{
        NSString *regexStr = @"([0]|([1-9][0-9]*))([.][0-9]+)?";

        NSRange intRange = [inputText rangeOfString:regexStr options:NSRegularExpressionSearch];
        if (intRange.location != NSNotFound) {
            intString = [inputText substringWithRange:intRange];
            contentString = [inputText stringByReplacingOccurrencesOfString:intString withString:@""];
        }else{
            NSRange range4 = [inputText rangeOfString:@"[十][一|二|三|四|五|六|七|八|九|][块]{0,1}" options:NSRegularExpressionSearch];
            if (range4.location != NSNotFound) {
                NSString *subString4 = [inputText substringWithRange:range4];
                NSString *numberKey = [subString4 substringWithRange:NSMakeRange(1, 1)];
                NSString *numberObject = [self.numberDict objectForKey:numberKey];
                intString = [NSString stringWithFormat:@"%ld",(10 + [numberObject integerValue])];
                contentString = [inputText stringByReplacingOccurrencesOfString:subString4 withString:@""];
            }else{
                intString = [self numberStringWithInputText:inputText];
                contentString = _contentString;
            }
        }
    }
    
    NSLog(@"intString = %@",intString);
    NSLog(@"contentString = %@",contentString);
    NSString *totalString = [NSString stringWithFormat:@"%@%@",contentString,intString];
    MessageItem *message = [self parseStringToMessage:totalString withType:type];
    return message;
}

-(NSString *)numberStringWithInputText:(NSString *)inputText
{
    NSArray *numberArray = @[@"分",@"毛",@"块",@"十",@"百",@"千",@"万",@"亿"];
    NSString *numberString = @"";
    for(int i = 0; i< numberArray.count; i++){
        NSString *regexString = [NSString stringWithFormat:@"[一|二|三|四|五|六|七|八|九|十|两][%@]",numberArray[i]];
        NSRange range = [inputText rangeOfString:regexString options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            NSString *numberKey = [[inputText substringWithRange:range] substringToIndex:1];
            NSString *numberObj = [self.numberDict objectForKey:numberKey];
            double amountNumber = pow(10, i-2) * [numberObj integerValue];
            NSLog(@"number = %@",numberObj);
            numberString = [NSString stringWithFormat:@"%.2f",amountNumber];
            NSLog(@"numberString = %@",numberString);
            _contentString = [inputText stringByReplacingOccurrencesOfString:[inputText substringWithRange:range] withString:@""];
            return numberString;
            
        }
    }
    return numberString;
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
