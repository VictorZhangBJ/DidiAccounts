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
#import "MessageItem.h"
#import "AppDelegate.h"
@interface ViewController ()
{
    NSURL *_audioPlayURL;
    AVAudioRecorder *_audioRecorder;
}

@property (nonatomic, strong) InputView *inputView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) PopView *popView;
@property (nonatomic, strong) UIView *grayBackControl;

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
    [self initPopView];

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
    MessageItem *item1 = [MessageItem new];
    item1.createDate = [NSDate date];
    item1.content = @"星巴克拿铁";
    item1.amounts = 293.00;
    item1.categoryName = @"餐饮娱乐";
    
    [self.dataSource addObject:@[item1, item1,item1]];
    
    [self.dataSource addObject:@[item1, item1,item1]];


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
   
    MessageItem* item = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //cell.contentLabel.text = item.content;
    if (indexPath.section % 2 ==0) {
        cell.backgroundColor = tableViewBackColor_2;
    }else{
        cell.backgroundColor = tableViewBcakColor_1;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)initPopView
{
    
        
    self.grayBackControl = [[UIView alloc]initWithFrame:self.view.bounds];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(grayBackControlClick)];
    [self.grayBackControl addGestureRecognizer:tap];
    self.grayBackControl.userInteractionEnabled = YES;
    
    [window addSubview:self.grayBackControl];
    self.grayBackControl.hidden = YES;
    self.grayBackControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    
    
    
    self.popView = [PopView new];
    self.popView.delegate = self;
    self.popView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.popView];
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window.mas_left).offset(20);
        make.right.equalTo(window.mas_right).offset(-20);
        make.height.equalTo(@300);
        make.centerY.equalTo(window.mas_centerY);
    }];
    self.popView.hidden = YES;
    
   
}

-(void)grayBackControlClick
{
    NSLog(@"隐藏");
    //放心键盘
    [self.popView endEditing:YES];
}
-(void)updateHeight:(CGFloat)height
{
    
    
}

-(void)closePopView{
    [self hidePopView];
}

//弹出视图
-(void)showPopView
{
    self.grayBackControl.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.bottom.equalTo(self.view.mas_bottom).offset(-100);
            self.grayBackControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
            //[self.view layoutIfNeeded];
        }];
    } completion:^(BOOL finished) {
        
    }];
    
    
    self.popView.hidden = NO;
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.5;
    
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.1)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [self.popView.layer addAnimation:animation forKey:nil];
}

//隐藏弹出视图
-(void)hidePopView
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.bottom.equalTo(self.view.mas_bottom).offset(200);
            self.grayBackControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
            //[self.view layoutIfNeeded];
        }];
    } completion:^(BOOL finished) {
        self.grayBackControl.hidden = YES;

    }];
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.3;
    
    animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    
    
    NSMutableArray *values = [NSMutableArray array];
    
    
    
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.1)]];

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 0.01)]];


    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [self.popView.layer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束");
    self.popView.hidden = YES;
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
    [self showPopView];
}

-(void)endRecord
{
    
}

-(void)startRecord
{
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches begin");
    [self hidePopView];
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
