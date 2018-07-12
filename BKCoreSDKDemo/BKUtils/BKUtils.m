//
//  BKUtils.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKUtils.h"

@implementation BKUtils


/**
 根据颜色生成图片
 
 @param color 传入的颜色
 @return UIImage图片
 */
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 根据字符串生成qc
 
 @param str 需要的字符串
 @return 返回一个图片
 */
+(UIImage*)getQCWithString:(NSString*)str
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //过滤器恢复默认
    [filter setDefaults];
    
    //给过滤器添加数据
    NSString *string = str;
    
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    
    //将获取到的二维码添加到imageview上
    return [BKUtils createNonInterpolatedUIImageFormCIImage:image withSize:145];
}

/**
*  根据CIImage生成指定大小的UIImage
*
*  @param image CIImage
*  @param size  图片宽度
*/
 + (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
 {
         CGRect extent = CGRectIntegral(image.extent);
         CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
         // 1.创建bitmap;
         size_t width = CGRectGetWidth(extent) * scale;
         size_t height = CGRectGetHeight(extent) * scale;
         CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
         CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
         CIContext *context = [CIContext contextWithOptions:nil];
         CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
         CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
         CGContextScaleCTM(bitmapRef, scale, scale);
         CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
         // 2.保存bitmap到图片
         CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
         CGContextRelease(bitmapRef);
         CGImageRelease(bitmapImage);
         return [UIImage imageWithCGImage:scaledImage];
}

+ (NSString*)timeStampToTime:(NSString*)time
{
    // timeStampString 是服务器返回的13位时间戳
    NSString *timeStampString  = time;
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

+ (NSString *)DPLocalizedString:(NSString *)translation_key {
    
    NSString * LocalizableStr = NSLocalizedString(translation_key, nil);
    if ([[NSLocale preferredLanguages] objectAtIndex:0].length>0&&[[[NSLocale preferredLanguages] objectAtIndex:0] hasPrefix:@"zh"]) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        LocalizableStr = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    } else {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        LocalizableStr = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }
    return LocalizableStr;
}

//判断中英文
+(BOOL)iscnLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* preferredLang = [defs objectForKey:@"AppleLanguages"];
    if ([preferredLang count] > 0 && (![[preferredLang objectAtIndex:0] hasPrefix:@"zh"]) ) {
        return NO;
    }else{
        return YES;
    }
}

+ (void) showTitle:(NSString*)title :(id)view
{
    MBProgressHUD *mbHub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbHub.mode = MBProgressHUDModeCustomView;
    mbHub.detailsLabelText = title;
    mbHub.detailsLabelFont = [UIFont systemFontOfSize:14.0];
}

+ (void)dissHud:(id)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showSuccessWithStatus:(NSString *)showTitlestring time:(CGFloat)showTime sucessOrError:(int)numberValue {
    MBProgressHUD *mbHub = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
    mbHub.mode = MBProgressHUDModeCustomView;
    mbHub.detailsLabelText = showTitlestring;
    mbHub.detailsLabelFont = [UIFont systemFontOfSize:FONTNUMBER];
    [mbHub hide:YES afterDelay:2.0];
    // [mbHub hideAnimated:YES afterDelay:showTime];
}
@end
