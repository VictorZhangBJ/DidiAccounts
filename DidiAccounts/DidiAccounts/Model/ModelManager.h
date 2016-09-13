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

+(instancetype)sharedInstance;

-(MessageItem *)parseStringToMessage:(NSString *)inputText;

@end
