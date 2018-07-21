//
//  BKCoinQCCodeView.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCoinQCCodeView : UIView

@property (copy, nonatomic) void(^blockTransfer)(BKCoinDetailModel*);

/**
 币种的详情
 */
@property (strong, nonatomic) BKCoinDetailModel* coinDetail;


/**
 币种名称
 */
@property (strong, nonatomic) UILabel* labelTitle;


/**
 二维码
 */
@property (strong, nonatomic) UIImageView* imageViewQCCode;


/**
 钱包地址
 */
@property (strong, nonatomic) UILabel* labelAddress;
@end
