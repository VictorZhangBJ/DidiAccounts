//
//  ViewController.m
//  DidiAccounts
//
//  Created by victor on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"滴滴记账";
    [self initInputView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

-(void)initInputView{
    self.inputView = [UIView new];
    [self.view addSubview:self.inputView];
    self.inputView.backgroundColor = [UIColor lightGrayColor];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    
    self.textField = [UITextField new];
    [self.inputView addSubview:self.textField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"请输入消费内容和金额";
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.centerX.equalTo(self.inputView.mas_centerX);
        make.centerY.equalTo(self.inputView.mas_centerY);
        make.left.equalTo(self.inputView.mas_left).offset(60);
    }];
    
    //语言按钮
    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [speechBtn addTarget:self action:@selector(speechBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:speechBtn];
    [speechBtn setTitle:@"语音" forState:UIControlStateNormal];
    [speechBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputView.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.left.equalTo(self.inputView.mas_left);
    }];
    
    //文字按钮
    UIButton *textInputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [textInputBtn setTitle:@"文字" forState:UIControlStateNormal];
    [textInputBtn addTarget:self action:@selector(textInputBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:textInputBtn];
    [textInputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.inputView.mas_centerY);
        make.right.equalTo(self.inputView.mas_right);
        
    }];
    
    
}

-(void)speechBtnClick {
    
}

-(void)textInputBtnClick {
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

/*
 * 键盘改变了frame时候调用
 */
-(void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    //取出键盘动画的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //取得键盘最后的frame
    CGRect keyFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //控制器view需要移动的距离
    //CGFloat transformY = keyFrame.origin.y - self.view.frame.size.height;

    CGRect frame = self.view.frame;
    frame.size.height = keyFrame.origin.y;
    
    CGFloat curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //self.inputView.transform = CGAffineTransformMakeTranslation(0, transformY);
        
        [UIView setAnimationCurve:curve];
        self.view.frame = frame;
        [self.view layoutIfNeeded];
    }];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
