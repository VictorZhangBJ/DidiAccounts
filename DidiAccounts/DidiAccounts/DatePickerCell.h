//
//  DatePickerCell.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/18.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DatePickerCellDelegate <NSObject>

-(void)dateDidChange:(NSDate *)date;

@end

@interface DatePickerCell : UITableViewCell

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) id<DatePickerCellDelegate> delegate;

@end
