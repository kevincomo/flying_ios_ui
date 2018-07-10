//
//  BKErrorModel.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKErrorModel : NSObject

/**
 状态码
 */
@property (assign, nonatomic) NSInteger status;


/**
 错误信息
 */
@property (copy, nonatomic) NSString* msg;
@end
