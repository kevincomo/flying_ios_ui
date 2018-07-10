//
//  BKUtils.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKUtils : NSObject


/**
 根据颜色生成图片

 @param color 传入的颜色
 @return UIImage图片
 */
+(UIImage*) createImageWithColor:(UIColor*) color;


/**
 根据字符串生成qc

 @param str 需要的字符串
 @return 返回一个图片
 */
+(UIImage*)getQCWithString:(NSString*)str;

/**
 时间戳转换成时间

 @param time 时间戳
 @return 时间
 */
+ (NSString*)timeStampToTime:(NSString*)time;
@end
