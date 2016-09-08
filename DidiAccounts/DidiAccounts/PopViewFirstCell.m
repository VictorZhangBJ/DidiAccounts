//
//  PopViewFirstCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/7.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "PopViewFirstCell.h"
#import "AppConfigure/AppConfig.h"
#import "RootViewController/RootViewController.h"

@implementation PopViewFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.categoryBtn.layer.cornerRadius = self.categoryBtn.frame.size.width / 2.0;
    self.categoryBtn.layer.backgroundColor = icon_green_color.CGColor;
    
    self.contentTextView.delegate = self;
}

//根据文字改变cell大小

-(void)textViewDidChange:(UITextView *)textView
{
    //计算textView高度
    CGRect bounds = textView.bounds;
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    
    //让tableView重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell
{
//    UIView *gridView = [UIView new];
//    gridView.backgroundColor = [UIColor blueColor];
//    [self.contentView addSubview:gridView];
//    [gridView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
//        make.height.equalTo(@100);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//    }];
//    [self layoutIfNeeded];
    
//    [self.categoryLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.greaterThanOrEqualTo(self.contentView.mas_bottom).offset(-100);
//    }];
//    [self layoutIfNeeded];
//    NSLog(@"纳尼");
//    UITableView *tableView = [self tableView];
//    [tableView beginUpdates];
//    [tableView endUpdates];
    
    
}

@end
