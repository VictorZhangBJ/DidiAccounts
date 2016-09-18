//
//  LeftViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/2.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "LeftViewController.h"
#import "AppConfig.h"
#import "AdviceViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"
#import "SlideMenuViewController.h"
@interface LeftViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageNameArray;


@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_LEFTVIEW_BACKGROUND;
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH * LEFTVIEW_SCALE);
    }];
    
    self.userImageView = [[UIImageView alloc]init];
    [self.userImageView setImage:[UIImage imageNamed:@"user"]];
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = 33.0;
    [backView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(backView.mas_top).offset(90);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    self.userNameLabel = [UILabel new];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.font = [UIFont systemFontOfSize:17];
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userNameLabel.text = @"Victor";
    [backView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(3);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [backView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(90);
        make.centerX.equalTo(backView.mas_centerX);
        make.left.equalTo(backView.mas_left).offset(20);
        make.height.mas_equalTo(132);
    }];
    self.dataSource = @[@"关于我们", @"意见反馈",@"设置"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = COLOR_LEFTVIEW_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.imageNameArray = @[@"about", @"advice", @"setting"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(10);
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    
    label.text = [self.dataSource objectAtIndex:indexPath.row];
    headImageView.image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:indexPath.row]];
    
    cell.backgroundColor = COLOR_LEFTVIEW_BACKGROUND;
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_LEFTVIEW_CELL_SELECTED;
    cell.selectedBackgroundView = view;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showView:[AboutViewController new]];
        
    }else if (indexPath.row == 1){
        [self showView:[AdviceViewController new]];
    }else{
        [self showView:[SettingViewController new]];
    }
}

-(void)showView:(UIViewController *)vc
{
    [self.slider hideSideView];
    [self.slider.centerViewController pushViewController:vc animated:YES];
    self.slider.pan.enabled = NO;

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
