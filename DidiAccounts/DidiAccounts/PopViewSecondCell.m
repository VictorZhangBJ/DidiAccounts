//
//  PopViewSecondCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "PopViewSecondCell.h"

@implementation PopViewSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithMessage:(MessageItem *)message
{
    self.calenderLabel.text = message.dateString;
}

@end
