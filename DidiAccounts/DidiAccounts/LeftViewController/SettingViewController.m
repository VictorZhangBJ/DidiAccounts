//
//  SettingViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/18.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)initTableView
{
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.dataSource = @[@[@"账号管理"],
                        @[@"月预算设置", @"细分类目管理"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UIImageView *headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
        [cell.contentView addSubview:headImageView];
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-10);
        }];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = 14;
    }else{
        if (indexPath.row == 0) {
            
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
        }
    }
    return cell;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 0) {
        NSLog(@"推出account");
        AccountViewController *avc = [[AccountViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
    }else{
        if (indexPath.row == 0) {
            
        }else{
            
        }
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
