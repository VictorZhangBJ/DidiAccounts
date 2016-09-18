//
//  SlideMenuViewController.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/2.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UINavigationController *centerViewController;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

+(instancetype)sharedInstance;

-(void)showSideView;

-(void)hideSideView;

@end
