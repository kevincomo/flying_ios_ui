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
 type  1转账 2 充值
 */
@property (assign, nonatomic) NSInteger type;

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
 转账id
 */
@property (copy, nonatomic) NSString* transferId;

@end
