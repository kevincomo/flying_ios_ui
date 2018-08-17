//
//  BKNetWorkHelper.h
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef DEBUG

#define DLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] )

#else

#define DLog( s, ... )

#endif

typedef void (^BKCompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^BKSuccessBlock)(NSDictionary *data);
typedef void (^BKFailureBlock)(NSError *error);



@interface BKNetWorkHelperCO : NSObject


/**
 get请求

 @param url 访问的url
 @param parameters 访问参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(BKSuccessBlock)successBlock failure:(BKFailureBlock)failureBlock;


/**
 post请求

 @param url 访问的url
 @param parameters 访问的参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(BKSuccessBlock)successBlock failure:(BKFailureBlock)failureBlock;



@end
