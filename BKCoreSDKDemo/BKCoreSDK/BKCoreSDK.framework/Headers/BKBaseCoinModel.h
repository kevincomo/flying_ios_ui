//
//  BKBaseCoinModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKBaseCoinModel : NSObject




/**
 币种的图标url
 */
@property (copy, nonatomic) NSString* icon;


/**
 币种的代码（BTC ETH）
 */
@property (copy, nonatomic) NSString* code;


/**
 币种的中文名称（比特币，柚子）
 */
@property (copy, nonatomic) NSString* name;


/**
 1 表示已添加 0 未添加
 */
@property (copy, nonatomic) NSString* status;



@end
