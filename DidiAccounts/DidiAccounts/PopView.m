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
#import "PopViewSecondCell.h"


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
    [self.tableView registerNib:[UINib nibWithNibName:@"PopViewSecondCell" bundle:nil] forCellReuseIdentifier:@"PopViewSecondCell"];
    [self.tableView registerClass:[GridViewCell class] forCellReuseIdentifier:@"GridViewCell"];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payBtn.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.greaterThanOrEqualTo(self.mas_bottom).offset(3);
    }];
    self.dataSource = [NSMutableArray new];
    [self.dataSource addObject:@"1"];
    [self.dataSource addObject:@"2"];
    [self.dataSource addObject:@"3"];
    
    UIView *hLine = [UIView new];
    hLine.backgroundColor = PopViewSepratorLine_color;
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.tableView.mas_top).offset(-1);
    }];
    
    
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 1, screen_width - 40, 1);
    self.tableView.tableFooterView = footerView;
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
    NSUInteger offset = 0;
    if (self.dataSource.count >= 3) {
        offset = self.dataSource.count - 3;
    }
    if (indexPath.row == 0) {
        
        PopViewFirstCell *cell = (PopViewFirstCell *)[tableView dequeueReusableCellWithIdentifier:@"PopViewFirstCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.row == 1 + offset){
        PopViewSecondCell *cell = (PopViewSecondCell *)[tableView dequeueReusableCellWithIdentifier:@"PopViewSecondCell" forIndexPath:indexPath];
        return  cell;
    }else if(indexPath.row == self.dataSource.count - 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        //保存按钮
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        saveBtn.layer.cornerRadius = 5.0;
        saveBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.31 blue:0.29 alpha:1.00];
        [cell.contentView addSubview:saveBtn];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(20);
            make.right.equalTo(cell.contentView.mas_right).offset(-20);
            make.height.equalTo(@35);
            make.top.equalTo(cell.contentView.mas_top).offset(20);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-20);
        }];
        return cell;
    }else{
        GridViewCell *cell = (GridViewCell *)[tableView dequeueReusableCellWithIdentifier:@"GridViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;

    }
   
    
}

#pragma  mark - GridViewDelegate

-(void)categoryBtnClickWithTag:(NSInteger)tag
{
    PopViewFirstCell *cell = (PopViewFirstCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell.categoryBtn setImage:[UIImage imageNamed:[[AppConfig gridViewBigButtonNameArray] objectAtIndex:tag]] forState:UIControlStateNormal];
    cell.categoryLabel.text = [[AppConfig giridViewLabelNameArray] objectAtIndex:tag];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        PopViewFirstCell *cell = (PopViewFirstCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.separatorInset = UIEdgeInsetsZero;
        if (self.dataSource.count > 3) {
            //删除操作
            
            self.tableView.separatorColor = PopViewSepratorLine_color;
            //改变cell箭头方向，改为向下
            [cell configureCellWithDirecton:NO];
            
            [self.tableView beginUpdates];
            [self.dataSource removeLastObject];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];

            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@300);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            
            
            [_delegate updateHeight:300];
            
        }else{
            //插入操作
            
            [_delegate updateHeight:472];
            
            //改变cell箭头方向，改为向上
            [cell configureCellWithDirecton:YES];
            
           
            
            self.tableView.separatorColor = GridViewCell_backColor;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@472);
                    
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            
            [self.tableView beginUpdates];
            [self.dataSource addObject:@"100"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];
            
        }
        
        //[self.tableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)saveBtnClick
{
    
}

-(void)deleteBtnClick
{
    NSLog(@"popView 删除按钮点击");
    [_delegate deleteBtnClick];
}

-(void)closeBtnClick
{
    [_delegate closePopView];
}
@end
