//
//  BKAllCoinsTableViewCell.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/11.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKAllCoinsTableViewCell : UITableViewCell

//icon
@property (strong, nonatomic) UIImageView* imageViewIcon;

//title
@property (strong, nonatomic) UILabel* labelCoinCode;

//name
@property (strong, nonatomic) UILabel* labelCoinName;

//开关
@property (strong, nonatomic) UISwitch* switchSelect;

//开关的返回
@property (copy, nonatomic) void (^blockSwitch)(BKCoinDetailModel*);

//币种的model
@property (strong, nonatomic) BKCoinDetailModel* coinDetail;

@end
