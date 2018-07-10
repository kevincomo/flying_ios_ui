//
//  BKTransferResultModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKTransferResultModel : NSObject

/**
 1成功 0 失败
 */
@property (copy, nonatomic) NSString* status;


/**
 订单id
 */
@property (copy, nonatomic) NSString* orderId;



/**
 信息
 */
@property (copy, nonatomic) NSString* msg;

@end
