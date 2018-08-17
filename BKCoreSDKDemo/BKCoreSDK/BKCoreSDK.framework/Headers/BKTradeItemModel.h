//
//  BKTradeItemModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKTradeItemModel : NSObject





/**
 type  out转账 in 充值
 */
@property (copy, nonatomic) NSString* type;

/**
 转出地址
 */
@property (copy, nonatomic) NSString* from;

/**
 转入地址
 */
@property (copy, nonatomic) NSString* to;

/**
 转账时间
 */
@property (copy, nonatomic) NSString* createdAt;

/**
 转账金额
 */
@property (copy, nonatomic) NSString* amount;

/**
 success 转账成功，failed 转账失败， pending 等待
 */
@property (copy, nonatomic) NSString* status;

/**
 转账id
 */
@property (copy, nonatomic) NSString* transferId;

@end
