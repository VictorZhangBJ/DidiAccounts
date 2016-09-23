//
//  BillsHeaderView.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/22.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillsHeaderView : UIView
@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *payPropertionLabel;
@property (nonatomic, strong) UILabel *incomePropertionLabel;
@property (nonatomic, strong) UIButton *triangleBtn;
@property (nonatomic, strong) UIView *dateView;

@end
