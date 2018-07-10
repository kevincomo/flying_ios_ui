//
//  BKTransferModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKCoinFeeModel.h"

@interface BKTransferModel : NSObject



/**
 转入地址
 */
@property (copy, nonatomic) NSString* to;

/**
 转出地址
 */
@property (copy, nonatomic) NSString* from;

/**
 币的类型
 */
@property (copy, nonatomic) NSString* coin;


/**
 转出币的数量
 */
@property (copy, nonatomic) NSString* amount;


/**
 手续费
 */
@property (strong, nonatomic) BKCoinFeeModel* fee;


/**
 1转账 2红包
 */
@property (copy, nonatomic) NSString* type;

@end
