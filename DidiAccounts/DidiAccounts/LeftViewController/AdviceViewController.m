//
//  AdviceViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/18.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()<UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *placeholder_textField;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    self.view.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
    [self initTextView];

    // Do any additional setup after loading the view.
}

-(void)initTextView
{
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@180);
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:13];
    self.textView.textColor = [UIColor darkGrayColor];
    
    
    self.placeholder_textField = [[UITextField alloc] init];
    self.placeholder_textField.font = [UIFont systemFontOfSize:13];
    self.placeholder_textField.textColor = [UIColor lightGrayColor];
    [self.textView addSubview:self.placeholder_textField];
    [self.placeholder_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_left).offset(5);
        make.right.equalTo(self.textView.mas_right);
        make.top.equalTo(self.textView.mas_top);
        make.height.equalTo(@30);
    }];
    self.placeholder_textField.placeholder = @"请输入";
    self.placeholder_textField.borderStyle = UITextBorderStyleNone;
    self.placeholder_textField.delegate = self;
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.text = @"可留下联系方式，方便给您反馈";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.textView.mas_bottom).offset(15);
        
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.textColor = [UIColor blackColor];
    self.textField.placeholder = @"QQ/微信/邮箱";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.font = [UIFont systemFontOfSize:16];
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 19, 44)];
    self.textField.leftView = leftview;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@50);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = COLOR_NAVIGATION_BAR;
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
    }];
    submitBtn.layer.cornerRadius = 22;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textView 开始输入");
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textview 开始编辑");
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textView 开始change");
    if (textView.text.length !=0) {
        self.placeholder_textField.hidden = YES;
    }else{
        self.placeholder_textField.hidden = NO;
    }
}
-(void)submitBtnClick
{
    NSLog(@"提交按钮");
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_LEFTVIEW object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
