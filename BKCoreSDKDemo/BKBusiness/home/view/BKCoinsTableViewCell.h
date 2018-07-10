//
//  BKCoinsTableViewCell.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCoinsTableViewCell : UITableViewCell


@property (copy, nonatomic) void(^blockQCCode)(BKCoinDetailModel*);

//币种图标
@property (strong, nonatomic) UIImageView* imageViewIcon;

//币名称
@property (strong, nonatomic) UILabel* labelName;

//持有币种
@property (strong, nonatomic) UILabel* labelHoldCoin;

//持有币种对应的法币
@property (strong, nonatomic) UILabel* labelHoldCurry;

//行情
@property (strong, nonatomic) UILabel* labelTicker;

//趋势
@property (strong, nonatomic) UILabel* labelMargin;

//二维码
@property (strong, nonatomic) UIImageView* imageViewQRCode;


@property (strong, nonatomic) BKCoinDetailModel* coinDetail;

@end
