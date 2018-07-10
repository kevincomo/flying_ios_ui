//
//  BKTransferFeeTableViewCell.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/7.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCoinFeeSecModel.h"

@interface BKTransferFeeTableViewCell : UITableViewCell

//icon
@property (strong, nonatomic) UIImageView* imageViewIcon;

//text
@property (strong, nonatomic) UILabel* labelText;

//点击选中
@property (copy, nonatomic) void (^blockClickSec)(void);

@property (strong, nonatomic) BKCoinFeeSecModel* coinFeeModel;
@end
