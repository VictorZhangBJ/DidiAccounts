//
//  MyTextCell.m
//  DidiAccounts
//
//  Created by 张佳宾 on 16/8/30.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "MyTextCell.h"
#import "RootViewController.h"
#define AVATAR_WIDTH 44.0


@implementation MyTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initCell];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCell{
    
    self.headeImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headeImageView];
    [self.headeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AVATAR_WIDTH, AVATAR_WIDTH));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    self.headeImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headeImageView.layer.borderWidth = 0.5f;
    
    self.chatBgImageView = [[UIImageView alloc]init];
    self.chatBgImageView.backgroundColor = [UIColor orangeColor];
    self.chatBgImageView.image = [UIImage imageNamed:@"sendTextNodeBkg"];
    [self.contentView addSubview:self.chatBgImageView];
    [self.chatBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.width.equalTo(@80);
        make.top.equalTo(self.headeImageView.mas_top);
        make.right.equalTo(self.headeImageView.mas_left).offset(-3);
    }];
    
    self.chatTextView = [[UITextView alloc]init];
    self.chatTextView.backgroundColor = [UIColor grayColor];
    self.chatTextView.textColor = [UIColor blackColor];
    self.chatTextView.font = [UIFont systemFontOfSize:13];
    [self.chatBgImageView addSubview:self.chatTextView];
    [self.chatTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chatBgImageView.mas_left).offset(11);
        make.top.equalTo(self.chatBgImageView.mas_top).offset(8);
        make.right.equalTo(self.chatBgImageView.mas_right).offset(-16);
        make.bottom.equalTo(self.chatBgImageView.mas_bottom).offset(-15);
        
    }];

}
-(void)setCellValue:(NSString *)str
{
    //计算string的高宽，重新设置约束
    self.chatTextView.text = str;
    CGSize sizeToFit = [self.chatTextView sizeThatFits:CGSizeMake(200, MAXFLOAT)];
    NSLog(@"size = %@", NSStringFromCGSize(sizeToFit));
    self.cellHeight = sizeToFit.height + 29;
    
    //更新约束
//    [self.chatBgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(sizeToFit.width + 27, sizeToFit.height + 23));
//        
//    }];
    
}

@end
