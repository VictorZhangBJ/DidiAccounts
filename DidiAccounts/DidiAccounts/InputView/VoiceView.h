//
//  VoiceView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/20.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceView : UIView

-(void)startRecord;

-(void)endRecord;

-(void)cancelRecord;

-(void)volumeDidChange:(NSInteger)volume;

-(void)speechBtnTouchUpOutside;

@end
