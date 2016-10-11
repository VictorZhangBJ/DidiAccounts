//
//  AddCategoryViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/11.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "ModelManager.h"
@interface AddCategoryViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
    [self initBackBtn];
    // Do any additional setup after loading the view.
    [self initView];
    self.title = @"添加分类";
}

-(void)initView
{
    self.textField = [[UITextField alloc]init];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.height.equalTo(@50);
    }];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    //UIButton *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 12, 26, 26)];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setImage:[UIImage imageNamed:@"custom_H"] forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(24, 12, 26, 26);
    
    [leftView addSubview:imageBtn];
    imageBtn.backgroundColor = COLOR_ICON_GREEN;
    imageBtn.layer.masksToBounds = YES;
    imageBtn.layer.cornerRadius = 13;
    self.textField.leftView =leftView;
    self.textField.placeholder = @"自定义输入名称";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBtn setTitle:@"确定添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = COLOR_NAVIGATION_BAR;
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@44);
        make.top.equalTo(self.textField.mas_bottom).offset(30);
    }];
    addBtn.layer.cornerRadius = 22;
    
}

-(void)btnClick
{
    RLMResults<CategoryItem *> *categorys = [CategoryItem allObjects];
    NSUInteger count = categorys.count;
    CategoryItem *item = [[CategoryItem alloc]init];
    item.category_name = self.textField.text;
    item.category_number = count;
    item.category_image_name = @"custom_H";
    item.category_big_image_name = @"custom_B";
    [[[ModelManager sharedInstance] realm] beginWriteTransaction];
    [[[ModelManager sharedInstance] realm] addOrUpdateObject:item];
    [[[ModelManager sharedInstance] realm] commitWriteTransaction];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"分类添加成功" preferredStyle:UIAlertControllerStyleAlert];
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
