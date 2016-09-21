//
//  DatePickerCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/18.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "DatePickerCell.h"
#import "RootViewController.h"

@implementation DatePickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}
-(void)configureCell
{
    self.contentView.backgroundColor = COLOR_GRIDVIEW_CELL;
    self.datePicker = [[UIDatePicker alloc]init];
    [self.contentView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@216);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = [NSDate date];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self.datePicker addTarget:self action:@selector(dateDidChange) forControlEvents:UIControlEventValueChanged];
    [self.datePicker setCalendar:[NSCalendar currentCalendar]];
    [self.datePicker setTimeZone:[NSTimeZone defaultTimeZone]];

}

-(void)dateDidChange
{
    NSDate *date = self.datePicker.date;
    NSLog(@"date = %@",date);
    if ([_delegate respondsToSelector:@selector(dateDidChange:)]) {
        [_delegate dateDidChange:date];
    }
}
@end
