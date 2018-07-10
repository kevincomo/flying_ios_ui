//
//  BKCoinModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCoinModel : NSObject



/**
 币种钱包地址
 */
@property (copy, nonatomic) NSString* address;


/**
 币种余额
 */
@property (copy, nonatomic) NSString* balance;


/**
 币种价格
 */
@property (copy, nonatomic) NSString* price;

@end
