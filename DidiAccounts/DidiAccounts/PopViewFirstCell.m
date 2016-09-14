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
{
    BOOL _isDown;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.categoryBtn.layer.cornerRadius = self.categoryBtn.frame.size.width / 2.0;
    self.categoryBtn.layer.backgroundColor = icon_green_color.CGColor;
    
    self.contentTextView.delegate = self;
    //设置页边距
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.amountTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self drawTriangle];
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

-(void)configureCellWithDirecton:(BOOL)isDown
{
    if (isDown == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.triangleView.hidden = NO;

            self.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowBtn.transform = CGAffineTransformMakeRotation(0);
            self.triangleView.hidden = YES;

        } completion:^(BOOL finished) {
        }];
        
    }
}

//绘制三角形
-(void)drawTriangle
{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.frame = self.triangleView.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = self.triangleView.bounds.size.width;
    [path moveToPoint:CGPointMake(0, width)];
    [path addLineToPoint:CGPointMake(width / 2.0, 2)];
    [path addLineToPoint:CGPointMake(width, width)];
    [path addLineToPoint:CGPointMake(0, width)];
    layer.fillColor = GridViewCell_backColor.CGColor;
    layer.path = path.CGPath;
    [self.triangleView.layer addSublayer:layer];
    self.triangleView.hidden = YES;
}

-(void)setCellWithMessage:(MessageItem *)message
{
    if (message.type == 0) {
        //支出模式
        self.amountTextView.textColor = icon_green_color;
        self.amountTextView.text = [NSString stringWithFormat:@"-%.2f",message.amounts];
        self.categoryBtn.backgroundColor = icon_green_color;
    }else{
        self.amountTextView.textColor = icon_red_color;
        self.amountTextView.text = [NSString stringWithFormat:@"+%.2f",message.amounts];
        self.categoryBtn.backgroundColor = icon_red_color;
    }
    self.categoryLabel.text = message.category_name;
    self.contentTextView.text = message.content;
    [self.categoryBtn setImage:[UIImage imageNamed:[[AppConfig gridViewBigButtonNameArray] objectAtIndex:message.category_number]] forState:UIControlStateNormal];
}

@end
