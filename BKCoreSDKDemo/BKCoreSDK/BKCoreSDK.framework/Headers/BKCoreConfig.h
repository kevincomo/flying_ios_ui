//
//  BKCoreConfig.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日志输出级别
 */
typedef enum {
    BKLogLevelDebug = 0, /* 输出所有日志 */
    BKLogLevelNo,   /* 不输出日志 */
} BKLogLevel;

@interface BKCoreConfig : NSObject


/**
 appId  后台生成
 */
@property (copy, nonatomic) NSString* appId;


/**
 uId  第三方自己的
 */
@property (copy, nonatomic) NSString* uId;


/**
 secretKey 后台生成
 */
@property (copy, nonatomic) NSString* secretKey;


/**
 语言 中文CN 英文EN  默认中文
 */
@property (copy, nonatomic) NSString* language;


/**
 法币币种 CNY,USD  默认CNY
 */
@property (copy, nonatomic) NSString* currecy;

/**
 是否使用https  默认使用YES  不适用NO
 */
@property (nonatomic, assign) BOOL usingHttps;


/**
 *  控制台是否输出log, 默认为NO
 */
@property (nonatomic, assign) BOOL enableConsoleLog;

/**
 *  日志输出级别, 默认为EMLogLevelDebug
 */
@property (nonatomic, assign) BKLogLevel logLevel;


@end
