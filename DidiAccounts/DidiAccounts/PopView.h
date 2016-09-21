//
//  PopView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/7.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewCell.h"
#import "Model/MessageItem.h"
#import "DatePickerCell.h"
#import "PopViewFirstCell.h"


@protocol PopViewDelegate <NSObject>


-(void)closePopView;

-(void)deleteBtnClick;

-(void)saveMessage:(MessageItem *)message;

@end

@interface PopView : UIView<UITableViewDelegate, UITableViewDataSource, GridViewDelegate, DatePickerCellDelegate, PopViewFirstCellDelegate>

@property (nonatomic, assign) id<PopViewDelegate> delegate;

@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UIButton *incomeBtn;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) MessageItem *message;

-(void)configureViewWithMessage:(MessageItem *)message;

@end
