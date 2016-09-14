//
//  GridViewCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "GridViewCell.h"
#import "AppConfig.h"
#import "RootViewController.h"

@implementation GridViewCell

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
    }
    return self;
}

-(void)setCellWithMessage:(MessageItem *)message
{
    UIView *backView = [UIView new];
    backView.backgroundColor = COLOR_GRIDVIEW_CELL;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@172);
        
    }];

    //创建按钮
    NSArray *btnNameArray = [AppConfig gridViewButtonNameArray];
    NSArray *labelNameArray = [AppConfig giridViewLabelNameArray];
    CGFloat btnWidth = 26;
    CGFloat offsetY = 10;
    CGFloat offsetX = btnWidth - 2 ;
    CGFloat spaceHeight = (172 - btnWidth * 3 - offsetY * 2 - 20) / 2.0;
    
    CGFloat spaceWidth = (self.frame.size.width - btnWidth * 5 - offsetX * 2) / 4.0;
    
    
    for(int i = 0; i < 11; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[btnNameArray objectAtIndex:i]] forState:UIControlStateNormal];
        CGFloat pointX = (i % 5) * (spaceWidth + btnWidth) + offsetX + 7;       //修正
        CGFloat pointY = (i / 5) * (spaceHeight + btnWidth) + offsetY;
        btn.frame = CGRectMake(pointX, pointY, btnWidth, btnWidth);
        if (message.type == 0) {
            btn.backgroundColor = COLOR_ICON_GREEN;
        }else{
            btn.backgroundColor = COLOR_ICON_RED;
        }
        
        btn.layer.cornerRadius = btnWidth / 2.0;
        [backView addSubview:btn];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //label
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(pointX - 12, pointY + 28, btnWidth + 24, 20);
        
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [labelNameArray objectAtIndex:i];
        [backView addSubview:label];
        
    }
    
}
-(void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(categoryBtnClickWithTag:)]) {
        [_delegate categoryBtnClickWithTag:btn.tag];
    }
}

@end
