//
//  ModelManager.h
//  DidiAccounts
//
//  Created by victor on 16/9/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageItem.h"

@interface ModelManager : NSObject

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) User *user;

+(instancetype)sharedInstance;

-(MessageItem *)parseStringToMessage:(NSString *)inputText withType:(NSInteger)type;
-(MessageItem *)parseVoiceStringToMessage:(NSString *)inputText withType:(NSInteger)type;

@end
