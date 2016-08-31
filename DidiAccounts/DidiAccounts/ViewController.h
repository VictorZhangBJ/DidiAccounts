//
//  ViewController.h
//  DidiAccounts
//
//  Created by victor on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <iflyMSC/IFlyMSC.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, IFlySpeechRecognizerDelegate, AVAudioRecorderDelegate>


@end

