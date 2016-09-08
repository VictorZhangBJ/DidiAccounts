//
//  ViewController.h
//  DidiAccounts
//
//  Created by victor on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "InputView/InputView.h"
#import "PopView.h"

@class SlideMenuViewController;
@interface ViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,
                                                 AVAudioRecorderDelegate,InputViewDelegate,PopViewDelegate>

@property (nonatomic, strong) SlideMenuViewController* slide;

@end

