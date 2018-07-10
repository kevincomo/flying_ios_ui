//
//  BKTransferFeeModel.h
//  BKCoreSDK
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKTransferFeeModel : NSObject


/**
 币种的代码
 */
@property (copy, nonatomic) NSString* coin;

/**
 转出地址
 */
@property (copy, nonatomic) NSString* from;

/**
 转入地址
 */
@property (copy, nonatomic) NSString* to;

/**
 转账金额
 */
@property (copy, nonatomic) NSString* amount;

@end
