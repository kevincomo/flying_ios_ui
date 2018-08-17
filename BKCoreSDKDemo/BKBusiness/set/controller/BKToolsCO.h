//
//  BKTools.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKToolsCO : NSObject


/**
 获取设备名称

 @return 设备名称字符串
 */
+ (NSString*)getDeviceName;

/**
 获取系统名称

 @return 系统名称字符串
 */
+ (NSString*)getSystemName;

/**
 获取系统版本号

 @return 系统版本号
 */
+ (NSString*)getSystemVersion;


/**
 获取设备模式

 @return 设备模式
 */
+ (NSString*)getDeviceModel;


/**
 获取本地设备模式

 @return 设备模式
 */
+ (NSString*)getLocModel;

/**
 获取应用名称

 @return 应用名称
 */
+ (NSString*)getAppName;

/**
 获取应用版本号

 @return 应用版本号
 */
+ (NSString*)getAppVersion;

/**
 获取SDK版本号

 @return SDK版本号
 */
+ (NSString*)getSDKVersion;

/**
 获取bundleId

 @return bundleId
 */
+ (NSString*)getBundleId;

/**
 哈希签名

 @return <#return value description#>
 */
+ (NSString *)SHA256:(NSString*)str;


/**
 Description

 @param title <#title description#>
 @param view <#view description#>
 */
+ (void) showTitle:(NSString*)title :(id)view;

/**
 <#Description#>

 @param view <#view description#>
 */
+ (void)dissHud:(id)view;

/**
 字典转换成字符串

 @param dict 传入的字典
 @return 返回的字符串
 */
+(NSString *)convertToJsonData:(NSDictionary *)dict;


/**
 去掉浮点后面多余的0

 @param string <#string description#>
 @return <#return value description#>
 */
+(NSString*)removeFloatAllZero:(NSString*)string;
@end
