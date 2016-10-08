//
//  BudgetViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "BudgetViewController.h"

@interface BudgetViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
    self.title = @"月预算设置";
    
    self.textField = [[UITextField alloc]init];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
        make.top.equalTo(self.view.mas_top).offset(20);
    }];
    self.textField.placeholder = @"输入预算金额";
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.textField.leftView = leftView;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.leftViewMode = UITextFieldViewModeAlways;

    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = COLOR_NAVIGATION_BAR;
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
        make.top.equalTo(self.textField.mas_bottom).offset(25);
    }];
    saveBtn.layer.cornerRadius = 20;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self initBackBtn];
}

-(void)saveBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"预算设置成功" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
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
