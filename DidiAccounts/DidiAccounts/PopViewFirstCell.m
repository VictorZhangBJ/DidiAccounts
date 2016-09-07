//
//  PopViewFirstCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/7.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "PopViewFirstCell.h"
#import "AppConfigure/AppConfig.h"

@implementation PopViewFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.categoryBtn.layer.cornerRadius = self.categoryBtn.frame.size.width / 2.0;
    self.categoryBtn.layer.backgroundColor = icon_green_color.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
