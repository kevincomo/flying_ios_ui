//
//  BKCoinFeeModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCoinFeeModel : NSObject





/**
 手续费数量
 */
@property (copy, nonatomic) NSString* fee;

/**
 币种
 */
@property (copy, nonatomic) NSString* coin;


/**
 对应的法币金额
 */
@property (copy, nonatomic) NSString* valuation;

@end
