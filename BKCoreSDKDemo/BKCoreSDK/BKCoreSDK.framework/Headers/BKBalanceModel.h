//
//  BKBalanceModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKBalanceModel : NSObject




/**
 总余额
 */
@property (copy, nonatomic) NSString* amount;

/**
 cny usd
 */
@property (copy, nonatomic) NSString* currency;


/**
 钱的符号
 */
@property (copy, nonatomic) NSString* symbol;
@end
