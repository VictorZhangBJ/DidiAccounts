//
//  ViewController.m
//  DidiAccounts
//
//  Created by victor on 16/8/26.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "MyTextCell.h"
#import "SelfTextCell.h"
#import "BaiduMobStat.h"
#import "HeaderView.h"
#import "AppConfigure/AppConfig.h"
#import "SlideMenuViewController.h"
#import "TableHeaderView/TableHeaderView.h"

@interface ViewController ()
{
    NSURL *_audioPlayURL;
    AVAudioRecorder *_audioRecorder;
}

@property (nonatomic, strong) InputView *inputView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = tableViewBcakColor_1;
    self.title = @"滴滴记账";
    [self initHeaderView];
    [self initTableView];
    [self initInputView];
    [self initNavigation];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"记账页面"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"记账页面"];
}

-(void)initNavigation
{
    //设置背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[AppConfig createImageWithColor:[AppConfig navigationTintColor]] forBarMetrics:UIBarMetricsDefault];
    //去除navigationBar底部线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    //menu按钮颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(slideMenuClick)];
}

-(void)slideMenuClick
{
    if (self.slide.isHidden) {
        [self.slide showSideView];
    }else{
        [self.slide hideSideView];
    }
}

-(void)initHeaderView
{
    self.headerView = [[HeaderView alloc]init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(106);
    }];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = tableViewBcakColor_1  ;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView registerClass:[MyTextCell class] forCellReuseIdentifier:@"MyTextCell"];
    //[self.tableView registerNib:[[[NSBundle mainBundle] loadNibNamed:@"SelfTextCell" owner:nil options:nil] lastObject] forCellReuseIdentifier:@"SelfTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelfTextCell" bundle:nil] forCellReuseIdentifier:@"SelfTextCell"];
    self.dataSource = [[NSMutableArray alloc]init];
    [self.dataSource addObject:@[@"买衣服200" ,@"吃饭 390"]];
    [self.dataSource addObject:@[@"打车 88", @"水电费 200"]];
    [self.dataSource addObject:@[@"打车 88", @"水电费 200"]];

    [self.dataSource addObject:@[@"打车 88", @"水电费 200"]];
    [self.dataSource addObject:@[@"打车 88", @"水电费 200"]];
    [self.dataSource addObject:@[@"打车 88", @"水电费 200"]];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderView *headerView = [[TableHeaderView alloc]init];
    [headerView configureViewWith:section];
    return headerView;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.inputView.textField resignFirstResponder];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[self.dataSource objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelfTextCell *cell = (SelfTextCell *)[tableView dequeueReusableCellWithIdentifier:@"SelfTextCell" forIndexPath:indexPath];
   
    cell.chatTextLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section % 2 ==0) {
        cell.backgroundColor = tableViewBackColor_2;
    }else{
        cell.backgroundColor = tableViewBcakColor_1;
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)initInputView{
    self.inputView = [[InputView alloc] init];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    
}

#pragma mark - InputViewDelegate
-(void)rightBtnClick
{
    [self.dataSource addObject:self.inputView.textField.text];
    [self.tableView reloadData];
    self.inputView.textField.text = @"";
}

-(void)endRecord
{
    
}

-(void)startRecord
{
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputView.textField resignFirstResponder];
}

/*
 * 键盘改变了frame时候调用
 */
-(void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    //取出键盘动画的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //取得键盘最后的frame
    CGRect keyFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //控制器view需要移动的距离
    CGFloat transformY = keyFrame.origin.y - self.view.frame.size.height - 64;

    CGRect frame = self.view.frame;
    frame.size.height = keyFrame.origin.y;
    
    CGFloat curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
//        self.inputView.transform = CGAffineTransformMakeTranslation(0, transformY);
//        
//        [UIView setAnimationCurve:curve];
//        self.view.frame = frame;
        NSLog(@"tranfromY = %f",transformY);
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.bottom.equalTo(self.view.mas_bottom).offset(transformY);
            make.centerX.equalTo(self.view.mas_centerX);
            make.left.equalTo(self.view.mas_left);
        }];
        
        //self.tableView.contentOffset = CGPointMake(0, -transformY);
        [self.view layoutIfNeeded];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.inputView.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
