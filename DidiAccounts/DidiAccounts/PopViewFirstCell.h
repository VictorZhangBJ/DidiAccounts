//
//  PopViewFirstCell.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/7.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/MessageItem.h"

@protocol PopViewFirstCellDelegate <NSObject>

-(void)amountDidChange:(NSString *)amount;
-(void)contentDidChange:(NSString *)content;

@end

@interface PopViewFirstCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *amountTextView;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView *triangleView;

@property (nonatomic, assign) id<PopViewFirstCellDelegate> delegate;
-(void)configureCellWithDirecton:(BOOL)isDown;
-(void)setCellWithMessage:(MessageItem *)message;

@end
