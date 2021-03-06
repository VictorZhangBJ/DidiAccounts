//
//  AppDelegate.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AppDelegate.h"
#import <iflyMSC/iflyMSC.h>
#import "BaiduMobStat.h"
#import "ViewController.h"
#import "SlideMenuViewController.h"
#import "GuideView.h"
#import "WXApi.h"
#import "AppConfig.h"

#define WeiXin_APPID @"wx50a2226f3e8b59a9"
#define IFLY_APPID @"57c64650"

@interface AppDelegate ()<WXApiDelegate>
@property (nonatomic, strong) GuideView *guideView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SlideMenuViewController *svc = [SlideMenuViewController sharedInstance];
    self.window.rootViewController = svc;
    [self.window makeKeyAndVisible];
    
    [self initiFlyMSC];
    [self initBaiduMob];
    [self initGuideView];
    [self initWeiXin];
    return YES;
}

-(void)initWeiXin
{
    [WXApi registerApp:WeiXin_APPID];
}
-(void)initGuideView
{
    NSDictionary *isLaunched = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLaunched"];
    if (isLaunched) {
        NSLog(@"已经启动过，不用加载引导页");
        return;
    }
    NSLog(@"第一次启动");
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isLaunched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.guideView = [[GuideView alloc] initWithFrame:[UIScreen mainScreen].bounds registerClick:^{
    } skipClick:^{
        [self.guideView dissmissFromSuperView];
    }];
    [self.window addSubview:self.guideView];
}
/**
 * 启动科大讯飞SDK
 */
-(void)initiFlyMSC
{
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];

    [IFlySpeechUtility createUtility: @"appid=57c64650"];
    
}
-(void)initBaiduMob
{
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [statTracker startWithAppId:@"42852e1b8b"];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}

//授权后回调
-(void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSLog(@"分享到微信回调");
    }else{
        SendAuthResp *aresp = (SendAuthResp *)resp;
        NSLog(@"erroCode = %d",aresp.errCode);
        if (aresp.errCode == 0) {
            NSDictionary *codeDic = @{@"code": aresp.code,
                                      @"lang":[[NSLocale preferredLanguages] objectAtIndex:0],
                                      @"country": [NSLocale currentLocale].localeIdentifier};
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CODE_RESPONSE object:codeDic];
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[IFlySpeechUtility getUtility] handleOpenURL:url];
    return YES;
}


@end
