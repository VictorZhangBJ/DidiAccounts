//
//  CategoryViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/10/9.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "CategoryViewController.h"
#import "AddCategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"细分类目管理";
    self.view.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
    // Do any additional setup after loading the view.
    [self initView];
    [self initBackBtn];
}

-(void)initView
{
    UIView *labelView = [UIView new];
    labelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(30);
        
    }];
    
    UILabel *label = [UILabel new];
    [labelView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelView.mas_left).offset(30);
        make.centerY.equalTo(labelView.mas_centerY);
    }];
    label.text = @"常用细分类目";
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor lightGrayColor];
    
    UIView *line = [UIView new];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(labelView.mas_bottom);
    }];
    line.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00];
    
    
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(line.mas_bottom);
        make.height.equalTo(@172);
    }];
    
    NSMutableArray *btnNameArray = [NSMutableArray arrayWithArray:[AppConfig gridViewButtonNameArray]];
    NSMutableArray *labelNameArray = [NSMutableArray arrayWithArray:[AppConfig giridViewLabelNameArray]];
    [btnNameArray addObject:@"add"];
    [labelNameArray addObject:@"添加"];
    
    CGFloat btnWidth = 26;
    CGFloat offsetY = 10;
    CGFloat offsetX = btnWidth - 2 ;
    CGFloat spaceHeight = (172 - btnWidth * 3 - offsetY * 2 - 20) / 2.0;
    
    CGFloat spaceWidth = (self.view.frame.size.width - btnWidth * 5 - offsetX * 2) / 4.0;
    
    
    for(int i = 0; i < btnNameArray.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[btnNameArray objectAtIndex:i]] forState:UIControlStateNormal];
        CGFloat pointX = (i % 5) * (spaceWidth + btnWidth) + offsetX + 7;       //修正
        CGFloat pointY = (i / 5) * (spaceHeight + btnWidth) + offsetY;
        btn.frame = CGRectMake(pointX, pointY, btnWidth, btnWidth);
        btn.backgroundColor = COLOR_ICON_GREEN;
       
        
        btn.layer.cornerRadius = btnWidth / 2.0;
        [backView addSubview:btn];
        [btn setTag:i];
        
        //label
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(pointX - 12, pointY + 28, btnWidth + 24, 20);
        
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [labelNameArray objectAtIndex:i];
        [backView addSubview:label];
        if (i == btnNameArray.count -1) {
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }

}

-(void)btnClick
{
    AddCategoryViewController *avc = [[AddCategoryViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES ];
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
