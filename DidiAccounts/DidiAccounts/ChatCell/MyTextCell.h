//
//  MyTextCell.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/30.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headeImageView;
@property (nonatomic, strong) UIImageView *chatBgImageView;
@property (nonatomic, strong) UITextView *chatTextView;
@property (nonatomic, strong) NSString *textString;
@property (nonatomic, assign) CGFloat cellHeight;

-(void)setCellValue:(NSString *)str;

@end
