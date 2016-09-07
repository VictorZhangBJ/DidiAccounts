//
//  TableHeaderView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/6.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView

@property (nonatomic, strong) UILabel *calenderLabel;
@property (nonatomic, strong) UILabel *totalLabel;

-(void)configureViewWith:(NSInteger)section;

@end
