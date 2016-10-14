//
//  SlideMenuViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/2.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "AppConfig.h"



@interface SlideMenuViewController ()
{
    CGFloat _prevX;
    CGFloat _maxOffsetX;
}

@end

@implementation SlideMenuViewController

static SlideMenuViewController* _instance = nil;

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
    });
    return _instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *vc = [[ViewController alloc]init];
    vc.slide = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.centerViewController = nav;
    [self.centerViewController.view setTag:1];

    
    LeftViewController *lvc = [[LeftViewController alloc]init];
    self.leftViewController = lvc;
    lvc.slider = self;
    [lvc.view setTag:2];

    
    [self.view addSubview:self.leftViewController.view ];
    [self.view addSubview:self.centerViewController.view];
    
    //添加滑动手势
     self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_centerViewController.view addGestureRecognizer:self.pan];
    self.pan.delegate = self;
    
    
    //添加点击手势
     self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    [_centerViewController.view addGestureRecognizer:self.tap];
    
    _prevX = 0;
    _maxOffsetX = self.view.frame.size.width * LEFTVIEW_SCALE;
    self.isHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftView) name:NOTIFICATION_SHOW_LEFTVIEW object:nil];
}

-(void)showLeftView
{
    [self showSideView];
    self.pan.enabled = YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)handleTap
{
    [self hideSideView];
    NSLog(@"slide 单击");
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return true;
}

-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    
    CGFloat translationPointX = [pan locationInView:self.view].x;
    if (pan.state == UIGestureRecognizerStateBegan) {
        _prevX = translationPointX;
    }
    CGFloat stepSpace = translationPointX - _prevX;
    
    
    CGAffineTransform tranfrom =  CGAffineTransformTranslate(_centerViewController.view.transform, stepSpace, 0);
    if (tranfrom.tx > _maxOffsetX || tranfrom.tx < 0) {
        return;
    }
    
    _centerViewController.view.transform = tranfrom;
    _prevX = translationPointX;
        
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat velocity = [pan velocityInView:self.view].x;
        if (velocity > 0) {
            //右滑动
            [self showSideView];
        }else{
            [self hideSideView];
        }
    }
}

-(void)showSideView
{
    [_leftViewController.view setHidden:NO];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _centerViewController.view.transform = CGAffineTransformMakeTranslation(_maxOffsetX, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    self.isHidden = NO;
    self.tap.enabled = YES;
}

-(void)hideSideView
{
    [_leftViewController.view setHidden:NO];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _centerViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    self.isHidden = YES;
    self.tap.enabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
