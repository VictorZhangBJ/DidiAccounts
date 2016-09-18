//
//  AccountViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/18.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    [self initTableView];
    self.view.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
    [self initBackBtn];
    // Do any additional setup after loading the view.
}

-(void)initTableView
{
    self.headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
    [self.view addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(self.view.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 30;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.dataSource = @[@[@"昵称", @"微信ID"],@[@"退出登录"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = COLOR_ADVICEVIEW_BACKGROUND;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return 20;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
        UILabel *label = [UILabel new];
        [cell.contentView addSubview:label];
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentRight;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-20);
        }];
        if (indexPath.row == 0) {
            label.text = @"Victor";
        }else{
            UIView *line = [UIView new];
            line.backgroundColor = COLOR_SETTINGVIEW_CELL_SEPARATOR;
            [cell addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top).offset(0);
                make.left.equalTo(cell.mas_left);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            label.text = @"815998382@qq.com";
        }
        
        
    }else{
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:COLOR_NAVIGATION_BAR forState:UIControlStateNormal];
        [cell.contentView addSubview:logoutBtn];
        [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    
    return cell;
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
