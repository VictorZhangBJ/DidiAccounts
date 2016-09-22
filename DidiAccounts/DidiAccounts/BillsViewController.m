//
//  BillsViewController.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/22.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "BillsViewController.h"
#import "SlideMenuViewController.h"
#import "BillsHeaderView.h"
#import "TableHeaderView/TableHeaderView.h"
#import "SelfTextCell.h"
#import "MessageItem.h"
#import "Model/ModelManager.h"


@interface BillsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BillsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property RLMResults<MessageItem*> *messages;


@end

@implementation BillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单查询页面";
    self.view.backgroundColor = COLOR_SELF_TEXT_CELL_ODD_COLOR;
    [self initBackBtn];
    [self initHeaderView];
    [self initTableView];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = COLOR_SELF_TEXT_CELL_ODD_COLOR  ;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SelfTextCell" bundle:nil] forCellReuseIdentifier:@"SelfTextCell"];
    self.dataSource = [[NSMutableArray alloc]init];
    MessageItem *item1 = [MessageItem new];
    item1.message_create_date = [NSDate date];
    item1.content = @"星巴克拿铁";
    item1.amounts = 293.00;
    item1.category_name = @"餐饮娱乐";
    [self configureDataSource];
    self.headerView.payLabel.text = [self monthPayString];
    self.headerView.incomeLabel.text = [self monthIncomeString];
    
}
-(void)configureDataSource
{
    self.messages = [MessageItem allObjects];
    self.messages = [self.messages sortedResultsUsingProperty:@"dateString" ascending:YES];
    
    self.dataSource = [[NSMutableArray alloc]init];
    NSMutableArray *array = [NSMutableArray new];
    MessageItem *preMessage = [self.messages objectAtIndex:0];
    for(MessageItem *message in self.messages){
        NSLog(@"date = %@",message.dateString);
        if ([preMessage.dateString isEqualToString:message.dateString]) {
            [array addObject:message];
        }else{
            [self.dataSource addObject:array];
            array = [NSMutableArray new];
            [array addObject:message];
        }
        preMessage = message;
    }
    [self.dataSource addObject:array];
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderView *headerView = [[TableHeaderView alloc]init];
    [headerView configureViewWith:section meesageArray:[self.dataSource objectAtIndex:section]];
    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[self.dataSource objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelfTextCell *cell = (SelfTextCell *)[tableView dequeueReusableCellWithIdentifier:@"SelfTextCell" forIndexPath:indexPath];
    
    MessageItem *message = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell configureCellWithMessage:message];
    
    if (indexPath.section % 2 ==0) {
        cell.backgroundColor = COLOR_SELF_TEXT_CELL_EVEN_COLOR;
    }else{
        cell.backgroundColor = COLOR_SELF_TEXT_CELL_ODD_COLOR;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(void)initHeaderView
{
    self.headerView = [[BillsHeaderView alloc]init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@126);
    }];
}


-(NSString *)monthPayString
{
    RLMResults<MessageItem *> *messages = [MessageItem objectsWhere:@"type = 0"];
    double number = [[messages sumOfProperty:@"amounts"] doubleValue];
    return [NSString stringWithFormat:@"%.2f",number];
}

-(NSString *)monthIncomeString
{
    RLMResults<MessageItem *> *messages = [MessageItem objectsWhere:@"type = 1"];
    double number = [[messages sumOfProperty:@"amounts"] doubleValue];
    return [NSString stringWithFormat:@"%.2f",number];

}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [SlideMenuViewController sharedInstance].pan.enabled = YES;
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
