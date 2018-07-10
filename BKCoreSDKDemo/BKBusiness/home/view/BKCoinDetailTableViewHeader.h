//
//  BKCoinDetailTableViewHeader.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCoinDetailTableViewHeader : UIView


/**
 币的名称
 */
@property (strong, nonatomic) UILabel* labelName;

/**
 币的数量
 */
@property (strong, nonatomic) UILabel* labelNumber;

/**
 币种对应的金额
 */
@property (strong, nonatomic) UILabel* labelAmount;

/**
 币地址
 */
@property (strong, nonatomic) UILabel* labelAddress;

@property (strong, nonatomic) BKCoinDetailModel* coinDetailModel;
@end
