//
//  BKTransferViewController.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKBasicViewController.h"

@interface BKTransferViewController : BKBasicViewController

@property (strong, nonatomic) BKCoinDetailModel* coinDetailModel;

/**
 转账model
 */
@property (strong, nonatomic) BKTransferModel* transferModel;

@end
