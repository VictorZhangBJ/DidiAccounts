//
//  SelfTextCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/30.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "SelfTextCell.h"
#import "AppConfig.h"
#import "RootViewController.h"

@implementation SelfTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerBtn.layer.cornerRadius = self.headerBtn.bounds.size.width / 2.0;
    self.headerBtn.adjustsImageWhenHighlighted = NO;
    self.headerBtn.backgroundColor = COLOR_ICON_RED;
    
    //分割线
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentLabel.mas_right).offset(10);
        make.left.greaterThanOrEqualTo(self.categoryNameLabel.mas_right).offset(10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureCellWithMessage:(MessageItem *)message
{
    self.categoryNameLabel.text = message.category_name;
    self.contentLabel.text = message.content;
    [self.headerBtn setImage:[UIImage imageNamed:[[AppConfig gridViewButtonNameArray] objectAtIndex:message.category_number]] forState:UIControlStateNormal];
    if (message.type == 0) {
        //支出模式
        [self.headerBtn setBackgroundColor: COLOR_ICON_GREEN];
        self.amountLabel.textColor = COLOR_ICON_GREEN;
        self.amountLabel.text = [NSString stringWithFormat:@"-%.2f",message.amounts];
    }else{
        //收入模式
        [self.headerBtn setBackgroundColor: COLOR_ICON_RED];
        self.amountLabel.textColor = COLOR_ICON_RED;
        self.amountLabel.text = [NSString stringWithFormat:@"+%.2f",message.amounts];
    }
}

@end
