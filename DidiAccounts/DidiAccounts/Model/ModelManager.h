//
//  ModelManager.h
//  DidiAccounts
//
//  Created by victor on 16/9/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageItem.h"
#import "CategoryItem.h"

@interface ModelManager : NSObject

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) User *user;

+(instancetype)sharedInstance;
-(void)configureRealm;


-(MessageItem *)parseStringToMessage:(NSString *)inputText withType:(NSInteger)type;
-(MessageItem *)parseVoiceStringToMessage:(NSString *)inputText withType:(NSInteger)type;
-(double)monthPayWithDate:(NSDate *)date;
-(double)monthIncomeWithDate:(NSDate *)date;
-(NSString *)getPoints;

@end
