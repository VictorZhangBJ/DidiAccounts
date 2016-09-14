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
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:message.message_create_date];
    self.calenderLabel.text = dateString;
}

@end
