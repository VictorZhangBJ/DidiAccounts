//
//  LoginViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/12.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NOTIFICATION_LOGIN_SUCCESS object:nil];
}

-(void)loginSuccess
{
    NSLog(@"登录界面，收到通知，消失");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initView
{
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_title"]];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.width.equalTo(@138);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(64);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"weixin_logo"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-20);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    loginBtn.layer.cornerRadius = 45;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *weixinText = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixin_text"]];
    [self.view addSubview:weixinText];
    [weixinText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(304, 20));
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"版权所有©北京善财信息技术有限公司";
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close_B"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(30);
    }];
    
}
-(void)closeBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginBtnClick
{
    [[APIManager sharedInstance] getCodeFromWeChat:^(NSDictionary *codeDic) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
