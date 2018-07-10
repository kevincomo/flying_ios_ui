//
//  BKTradeHistory.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKTradeItemModel.h"

@interface BKTradeHistory : NSObject





/**
 总条数
 */
@property (assign, nonatomic) NSInteger total;


/**
 转账列表
 */
@property (strong, nonatomic) NSArray<BKTradeItemModel*>* list;

@end
