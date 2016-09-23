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


@interface BillsViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) BillsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property RLMResults<MessageItem*> *messages;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *pickerDataSource;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;


@end

@implementation BillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单查询页面";
    self.view.backgroundColor = COLOR_SELF_TEXT_CELL_ODD_COLOR;
    [self configureDate];
    [self configureDataSource];
    [self initBackBtn];
    [self initHeaderView];
    [self initPickerView];
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
    MessageItem *item1 = [MessageItem new];
    item1.message_create_date = [NSDate date];
    item1.content = @"星巴克拿铁";
    item1.amounts = 293.00;
    item1.category_name = @"餐饮娱乐";
    self.headerView.payLabel.text = [self monthPayString];
    self.headerView.incomeLabel.text = [self monthIncomeString];
    [self.view bringSubviewToFront:self.pickerView];
}

-(void)configureDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:[NSDate date]];
    self.year = [NSString stringWithFormat:@"%ld",year];
    self.month = [NSString stringWithFormat:@"%ld",month];
}

-(void)configureDataSource
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateString BEGINSWITH %@ AND month == %d",self.year, [self.month integerValue]];
    self.messages = [MessageItem objectsWithPredicate:predicate];
    self.messages = [self.messages sortedResultsUsingProperty:@"dateString" ascending:YES];
    
    self.dataSource = [[NSMutableArray alloc]init];
    if (self.messages.count == 0) {
        return;
    }
    NSMutableArray *array = [NSMutableArray new];
    MessageItem *preMessage = [self.messages objectAtIndex:0];
    for(MessageItem *message in self.messages){
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
    NSLog(@"self.datasource.cont = %ld",self.dataSource.count);

    
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateTap)];
    [self.headerView.dateView addGestureRecognizer:tap];
}

-(void)dateTap
{
    if (self.pickerView.hidden) {
        self.pickerView.hidden = NO;
    }else{
        self.pickerView.hidden = YES;
        [self refreshView];
    }
}

-(void)refreshView
{
    [self configureDataSource];
    [self.tableView reloadData];
    self.headerView.payLabel.text = [self monthPayString];
    self.headerView.incomeLabel.text = [self monthIncomeString];
}
-(void)initPickerView
{
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(48);
        make.height.equalTo(@216);
    }];
    
    self.pickerDataSource = [NSMutableArray new];
    NSInteger year = [self.year integerValue];
    NSInteger month = [self.month integerValue];
    
    NSMutableArray *array = [NSMutableArray new];
    for(int i = 1970; i <= year; i++){
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.pickerDataSource addObject:array];
    [self.pickerDataSource addObject:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    [self.pickerView selectRow:month - 1 inComponent:1 animated:YES];
    [self.pickerView selectRow:year - 1970 inComponent:0 animated:YES];
    self.pickerView.hidden = YES;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.pickerDataSource objectAtIndex:component] count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerDataSource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.pickerDataSource objectAtIndex:component] objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component ==0) {
        self.year = [[self.pickerDataSource objectAtIndex:0] objectAtIndex:row];
    }else{
        self.month = [[self.pickerDataSource objectAtIndex:1] objectAtIndex:row];
    }
    self.headerView.dateLabel.text = [NSString stringWithFormat:@"%@年%@月",self.year, self.month];
}

-(NSString *)monthPayString
{
    RLMResults<MessageItem *> *messages = [self.messages objectsWhere:@"type = 0"];
    double number = [[messages sumOfProperty:@"amounts"] doubleValue];
    return [NSString stringWithFormat:@"%.2f",number];
}

-(NSString *)monthIncomeString
{
    RLMResults<MessageItem *> *messages = [self.messages objectsWhere:@"type = 1"];
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
