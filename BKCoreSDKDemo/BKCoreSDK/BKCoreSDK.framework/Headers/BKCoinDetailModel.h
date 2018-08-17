//
//  BKCoinDetailModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCoinDetailModel : NSObject

/**
 币种id
 */
@property (copy, nonatomic) NSString* cId;

/**
 币种的地址
 */
@property (copy, nonatomic) NSString* address;


/**
 // 持有币的数量
 */
@property (copy, nonatomic) NSString* amount;


/**
 持有币数量的价格
 */
@property (copy, nonatomic) NSString* price;


/**
 图标
 */
@property (copy, nonatomic) NSString* icon;


/**
 涨跌幅
 */
@property (copy, nonatomic) NSString* margin;


/**
 行情
 */
@property (copy, nonatomic) NSString* ticker;


/**
 币代码
 */
@property (copy, nonatomic) NSString* coin;


/**
 币名称
 */
@property (copy, nonatomic) NSString* name;


/**
 排序
 */
@property (copy, nonatomic) NSString* sort;


/**
 钱的符号
 */
@property (copy, nonatomic) NSString* symbol;


/**
 如果require为 yes，表示强制开启，不可关闭
 */
@property (copy, nonatomic) NSString* required;


/**
 off" // 表示已添加   on表示未添加
 */
@property (copy, nonatomic) NSString* enable;

/**
 中文名
 */
@property (copy, nonatomic) NSString* cnName;

/**
 英文名称
 */
@property (copy, nonatomic) NSString* enName;

/**
 小数点后精确位数
 */
@property (copy, nonatomic) NSString* fixed;
@end
