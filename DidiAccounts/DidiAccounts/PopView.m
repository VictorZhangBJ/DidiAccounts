//
//  PopView.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/7.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "PopView.h"
#import "RootViewController/RootViewController.h"
#import "AppConfigure/AppConfig.h"
#import "PopViewFirstCell.h"

@implementation PopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView
{
    //记账title
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"记账明细";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    //删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.equalTo(titleLabel.mas_top);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage: [UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.equalTo(titleLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    //占位图
    UIView *spaceOne = [UIView new];
    UIView *spaceTwo = [UIView new];
    [self addSubview:spaceOne];
    [self addSubview:spaceTwo];
    
    [spaceOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //支出按钮
    self.payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.payBtn setTitle:@"支出" forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.payBtn.layer.borderColor = icon_red_color.CGColor;
    self.payBtn.layer.borderWidth = 1.0;
    self.payBtn.layer.cornerRadius = 12;
    
    [self.payBtn setTitleColor:icon_red_color forState:UIControlStateNormal];
    [self addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(spaceOne.mas_right);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 24));
    }];
    
    //收入按钮
    self.incomeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.incomeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.incomeBtn setTitleColor:icon_green_color forState:UIControlStateNormal];
    [self.incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    
    self.incomeBtn.layer.borderWidth = 1.0f;
    self.incomeBtn.layer.borderColor = icon_green_color.CGColor;
    self.incomeBtn.layer.cornerRadius = 12;
    
    [self addSubview:self.incomeBtn];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payBtn.mas_top);
        make.left.equalTo(self.payBtn.mas_right).offset(20);
        make.width.equalTo(self.payBtn.mas_width);
        make.height.equalTo(self.payBtn.mas_height);
    }];
    
    [spaceTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(spaceOne.mas_width);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.incomeBtn.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopViewFirstCell" bundle:nil] forCellReuseIdentifier:@"PopViewFirstCell"];

    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payBtn.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    UIView *hLine = [UIView new];
    hLine.backgroundColor = [UIColor colorWithRed:0.88 green:0.89 blue:0.90 alpha:1.00];
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.tableView.mas_top).offset(-1);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PopViewFirstCell *cell = (PopViewFirstCell *)[tableView dequeueReusableCellWithIdentifier:@"PopViewFirstCell" forIndexPath:indexPath];
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        return  cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


-(void)deleteBtnClick
{
    NSLog(@"popView 删除按钮点击");
}

-(void)closeBtnClick
{
    
}
@end
