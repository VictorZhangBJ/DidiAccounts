//
//  PopViewSecondCell.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/MessageItem.h"

@interface PopViewSecondCell : UITableViewCell

-(void)setCellWithMessage:(MessageItem *)message;
@property (weak, nonatomic) IBOutlet UILabel *calenderLabel;

@end
