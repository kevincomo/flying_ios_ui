//
//  BKTools.m
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKToolsCO.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BKToolsCO

/**
 获取设备名称
 
 @return 设备名称字符串
 */
+ (NSString*)getDeviceName
{
    return [[UIDevice currentDevice] name];
}

/**
 获取系统名称
 
 @return 系统名称字符串
 */
+ (NSString*)getSystemName
{
    return [[UIDevice currentDevice] systemName];
}

/**
 获取系统版本号
 
 @return 系统版本号
 */
+ (NSString*)getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}


/**
 获取设备模式
 
 @return 设备模式
 */
+ (NSString*)getDeviceModel
{
    return [[UIDevice currentDevice] model];
}


/**
 获取本地设备模式
 
 @return 设备模式
 */
+ (NSString*)getLocModel
{
    return [[UIDevice currentDevice] localizedModel];
}

/**
 获取应用名称
 
 @return 应用名称
 */
+ (NSString*)getAppName
{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    return [dicInfo objectForKey:@"CFBundleDisplayName"];
}

/**
 获取应用版本号
 
 @return 应用版本号
 */
+ (NSString*)getAppVersion
{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    return [dicInfo objectForKey:@"CFBundleShortVersionString"];
}

/**
 获取SDK版本号
 
 @return SDK版本号
 */
+ (NSString*)getSDKVersion
{
    return @"1.0.0";
}

/**
 获取bundleId
 
 @return bundleId
 */
+ (NSString*)getBundleId
{
    return [[NSBundle mainBundle] bundleIdentifier];
}


+ (void) showTitle:(NSString*)title :(id)view
{
//    BKProgressHUD *mbHub = [BKProgressHUD showHUDAddedTo:view animated:YES];
//    mbHub.mode = MBProgressHUDModeCustomView;
//    mbHub.detailsLabelText = title;
//    mbHub.detailsLabelFont = [UIFont systemFontOfSize:14.0];
}

+ (void)dissHud:(id)view
{
  //  [BKProgressHUD hideHUDForView:view animated:YES];
}

+ (NSString *)SHA256:(NSString*)str
{
    const char *s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}


+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+(NSString*)removeFloatAllZero:(NSString*)string
{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

@end
