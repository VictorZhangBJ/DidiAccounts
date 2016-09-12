//
//  GridViewCell.h
//  DidiAccounts
//
//  Created by 张佳宾 on 16/9/8.
//  Copyright © 2016年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridViewDelegate <NSObject>

-(void)categoryBtnClickWithTag:(NSInteger)tag;

@end

@interface GridViewCell : UITableViewCell

@property (nonatomic, assign) id<GridViewDelegate> delegate;

@end
