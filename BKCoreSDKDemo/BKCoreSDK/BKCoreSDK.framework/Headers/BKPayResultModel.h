//
//  BKPayResultModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKPayResultModel : NSObject


/**
 0支付成功 其他失败
 */
@property (assign, nonatomic) NSNumber* status;

/**
 服务器返回信息
 */
@property (copy, nonatomic) NSString* msg;

@end
