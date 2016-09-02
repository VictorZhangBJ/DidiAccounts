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
@property (nonatomic, strong) UIViewController *centerViewController;

-(void)showSideView;

-(void)hideSideView;

@end
