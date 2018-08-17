//
//  BKNetWorkHelper.m
//  BKCore
//
//  Created by wxl on 2018/7/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKNetWorkHelperCO.h"
#import "BKToolsCO.h"
#import "configure.h"


#define ACCESS_TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:@"ACCESS_TOKEN"]


@implementation BKNetWorkHelperCO

//GET请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(BKSuccessBlock)successBlock failure:(BKFailureBlock)failureBlock
{
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:url];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in parameters) {
            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];
}

//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(BKSuccessBlock)successBlock failure:(BKFailureBlock)failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //设置请求类型
    request.HTTPMethod = @"POST";

    //将需要的信息放入请求头 随便定义了几个
    [request setValue:@"no-cache" forHTTPHeaderField:@"cache-control"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    if(ACCESS_TOKEN)
    {
        [request addValue:ACCESS_TOKEN forHTTPHeaderField:@"bk_token"];//token
    }
    
    [request addValue:@"ios" forHTTPHeaderField:@"platform"];//平台
    [request addValue:[BKCore sharedInstance].coreConfig.appId forHTTPHeaderField:@"appId"];//
    [request addValue:[BKCore sharedInstance].coreConfig.language forHTTPHeaderField:@"language"];//语言
    [request addValue:[BKCore sharedInstance].coreConfig.currency forHTTPHeaderField:@"currency"];//法币的类型
    [request addValue:[BKToolsCO getAppName] forHTTPHeaderField:@"appName"];
    [request addValue:[BKToolsCO getBundleId] forHTTPHeaderField:@"bundleId"];
    [request addValue:[BKToolsCO getSDKVersion] forHTTPHeaderField:@"sdkVersion"];
    [request addValue:[BKToolsCO getSystemName] forHTTPHeaderField:@"sysVersion"];
    [request addValue:[BKToolsCO getDeviceName] forHTTPHeaderField:@"deviceName"];
    [request addValue:[BKToolsCO getSystemVersion] forHTTPHeaderField:@"systemVersion"];
    
    if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
    {
        DLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    }
    
    
    //把参数放到请求体内
    
    
    //初始化SDK的时候需要签名 否则只需要填token
    if([url hasSuffix:API_BK_API_AUTH])
    {
        //签名
        NSDictionary *dicTem = [BKNetWorkHelperCO parseParams:parameters];
        
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicTem options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *postStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
        {
           DLog(@"请求参数url%@ = 参数%@",url,postStr);
        }
        
        request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *postStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
        {
             DLog(@"请求参数url%@ = 参数%@",url,postStr);
        }
        
        request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在这执行一些耗时操作
        //2,程序自动安装证书的方式
        NSURLSession *session = [NSURLSession sharedSession];
//        if([BKCore sharedInstance].coreConfig.usingHttps)
//        {
//             session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:(id)self delegateQueue:[[NSOperationQueue alloc]init]];
//        }
//        else
//        {
//             session = [NSURLSession sharedSession];
//        }
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) { //请求失败
                 if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                 {
                     DLog(@"url:%@ = 返回错误%@",url,error);
                 }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程进行操作
                    failureBlock(error);
                });
            } else {  //请求成功
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    DLog(@"url:%@ = 返回参数%@",url,dic);
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程进行操作
                    successBlock(dic);
                });
                
            }
        }];
        [dataTask resume];  //开始请求
        
        
    });
    
    
    
}

//重新封装参数 加入app相关信息
+ (NSDictionary *)parseParams:(NSDictionary *)params
{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:params];
//    [parameters setValue:@"ios" forKey:@"client"];
//    [parameters setValue:@"请替换版本号" forKey:@"auth_version"];
//    NSString* phoneModel = @"获取手机型号" ;
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];//ios系统版本号
//    NSString *system = [NSString stringWithFormat:@"%@(%@)",phoneModel, phoneVersion];
//    [parameters setValue:system forKey:@"system"];
//    NSDate *date = [NSDate date];
//    NSTimeInterval timeinterval = [date timeIntervalSince1970];
//    [parameters setObject:[NSString stringWithFormat:@"%.0lf",timeinterval] forKey:@"auth_timestamp"];//请求时间戳
//    NSString *devicetoken = @"请替换DeviceToken";
//    [parameters setValue:devicetoken forKey:@"uuid"];
    [parameters setValue:[BKCore sharedInstance].coreConfig.secretKey forKey:@"appSecret"];
    
    if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
    {
         DLog(@"请求参数:%@",parameters);
    }
   
    
//    NSString *keyValueFormat;
//    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    
    //加密处理 将所有参数加密后结果当做参数传递
    //parameters = @{@"i":@"加密结果 抽空加入"};
    //签名得到一个值
    NSString* str = [BKToolsCO SHA256:[BKNetWorkHelperCO getNeedSignStrFrom:parameters]];
    //移除secret
    [parameters removeObjectForKey:@"appSecret"];
    //将签名得到的值放入参数中
    [parameters setValue:str forKey:@"sign"];
    
//    NSEnumerator *keyEnum = [parameters keyEnumerator];
//    id key;
//    while (key = [keyEnum nextObject]) {
//        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
//        [result appendString:keyValueFormat];
//    }
    return parameters;
}




+(NSString *)getNeedSignStrFrom:(id)obj{
    NSDictionary *dict = obj;
    NSArray *arrPrimary = dict.allKeys;
    
    NSArray *arrKey = [arrPrimary sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;//NSOrderedAscending 倒序
    }];
    
    NSString*str =@"";
    
    for (NSString *s in arrKey) {
        id value = dict[s];
        if([value isKindOfClass:[NSDictionary class]]) {
            value = [self getNeedSignStrFrom:value];
        }
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@"&"];
            
        }
        
        str = [str stringByAppendingFormat:@"%@=%@",s,value];
        
    }
    
    if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
    {
        DLog(@"str=%@",str);
    }
    
    
    return str.lowercaseString;
}
#pragma mark -----NSURLSessionTaskDelegate-----

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    NSLog(@"didReceiveChallenge ");
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"server ---------");
        //        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        NSString *host = challenge.protectionSpace.host;
        if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
        {
            DLog(@"%@", host);
        }
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
    else if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate])
    {
        //客户端证书认证
        //TODO:设置客户端证书认证
        // load cert
        NSLog(@"client");
        NSString *path = [[NSBundle mainBundle]pathForResource:@"client"ofType:@"p12"];
        NSData *p12data = [NSData dataWithContentsOfFile:path];
        CFDataRef inP12data = (__bridge CFDataRef)p12data;
        SecIdentityRef myIdentity;
        OSStatus status = [self extractIdentity:inP12data toIdentity:&myIdentity];
        if (status != 0) {
            return;
        }
        SecCertificateRef myCertificate;
        SecIdentityCopyCertificate(myIdentity, &myCertificate);
        const void *certs[] = { myCertificate };
        CFArrayRef certsArray =CFArrayCreate(NULL, certs,1,NULL);
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:(__bridge NSArray*)certsArray persistence:NSURLCredentialPersistencePermanent];
        //        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        //         网上很多错误代码如上，正确的为：
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (OSStatus)extractIdentity:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("123456");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0)
    {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    else
    {
        NSLog(@"clinet.p12 error!");
    }
    
    if (options) {
        CFRelease(options);
    }
    return securityError;
}

@end
