//
//  BKJsBridgeCore.m
//  BKCoreSDK
//
//  Created by wxl on 2018/7/23.
//  Copyright © 2018年 wxl. All rights reserved.
//




#import "BKJsBridgeCore.h"
#import "BKNetWorkHelperCO.h"
#import "configure.h"
#import "BKToolsCO.h"
#include <signal.h>
#include <execinfo.h>


@interface BKJsBridgeCore ()

//token
@property (copy, nonatomic) NSString* token;


/**
 SDK当前版本号
 */
@property (strong, nonatomic) NSString* sdkVersion;

@end

@implementation BKJsBridgeCore

+(id)allocWithZone:(NSZone *)zone{
    return [BKJsBridgeCore sharedInstance];
}

+(BKJsBridgeCore *) sharedInstance{
    static BKJsBridgeCore * s_instance_dj_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance_dj_singleton = [[super allocWithZone:nil] init];
        s_instance_dj_singleton.coreConfig = [[BKCoreConfig alloc] init];
        s_instance_dj_singleton.sdkVersion = [BKToolsCO getSDKVersion];
        [s_instance_dj_singleton initHandler];
        
        
        
    });
    return s_instance_dj_singleton;
}

-(id)copyWithZone:(NSZone *)zone{
    return [BKJsBridgeCore sharedInstance];
}


-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return [BKJsBridgeCore sharedInstance];
}



- (void)setCoreConfig:(BKCoreConfig *)coreConfig
{
    _coreConfig = coreConfig;
    
}


- (void)initHandler {
    
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0,sizeof(newSignalAction));
    newSignalAction.sa_handler = &signalHandler;
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGSEGV, &newSignalAction, NULL);
    sigaction(SIGFPE, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGPIPE, &newSignalAction, NULL);
    
    //异常时调用的函数
    NSSetUncaughtExceptionHandler(&handleExceptions);
}
void handleExceptions(NSException *exception) {
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"crash.txt"];
    // 将一个txt文件写入沙盒
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// 沙盒的地址
NSString * applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)uploadLog
{
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"crash.txt"];
    
    NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:path];
    NSString *content = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [dicT setValue:content forKey:@"msg"];
    [dicT setValue:@"100001" forKey:@"code"];
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_API_LOG] parameters:dicT success:^(NSDictionary *dic) {
        
        NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"crash.txt"];
        BOOL bRet = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (bRet) {
            NSError *err;
            [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
        }
        
        
        
    } failure:^(NSError *errorCode) {
        
    }];
}
void signalHandler(int sig) {
    //最好不要写，可能会打印太多内容
    //NSLog(@"++++++++++++++++signal+++++++++++++++ = %d", sig);
}


- (void)logoutSDK
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ACCESS_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)typeAction:(NSString*)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //方法分类
    if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_initSdk])
    {
        BKCoreConfig* coreConfig = [[BKCoreConfig alloc] init];
        coreConfig.appId = [dic objectForKey:@"appId"];
        coreConfig.language = [dic objectForKey:@"language"];
        coreConfig.currency = [dic objectForKey:@"currency"];
        coreConfig.secretKey = [dic objectForKey:@"secretKey"];
        coreConfig.uId = [dic objectForKey:@"userId"];
        coreConfig.logLevel = [[dic objectForKey:@"logLevel"] intValue];
        coreConfig.environment = [dic objectForKey:@"environment"]; //dev 测试环境  open  发布环境
        [BKJsBridgeCore sharedInstance].coreConfig = coreConfig;
        [self initWithUserId:[dic objectForKey:@"userId"] withResult:^(BOOL bl) {
            
        } withFail:^(BKErrorModel *error) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getBalance])//获取钱包总余额
    {
        [self getTotalBalance:^(BKBalanceModel *code) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_removeUser])//移除用户
    {
        [self logoutSDK];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getCoinDetail])//获取币详情
    {
        [self getCodeDetail:[dic objectForKey:@"coin"] withResult:^(BKCoinModel *mol) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getUserCoinList])//获取币种列表选中
    {
        
        [self getCoinsWithType:@"default" withPage:[[dic objectForKey:@"page"] integerValue] withPageCount:[[dic objectForKey:@"size"] integerValue] withResult:^(NSArray<BKCoinDetailModel *> * arr, NSInteger count) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getCoinList])//获取所有币种的列表
    {
        [self getCoinsWithType:@"all" withPage:[[dic objectForKey:@"page"] integerValue] withPageCount:[[dic objectForKey:@"size"] integerValue] withResult:^(NSArray<BKCoinDetailModel *> * arr, NSInteger count) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_addCoin])//添加币种
    {
        [self addCoins:[dic objectForKey:@"coinId"] withResult:^(BOOL bl) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_delCoin])//删除币种
    {
        [self deleteCoin:[dic objectForKey:@"coinId"] withResult:^(BOOL bl) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_searchCoin])//搜索币种
    {
        [self searchCoinWithType:[dic objectForKey:@"coin"] withResult:^(BKCoinDetailModel *mo) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getTrades])//币种交易的详情
    {
        
        [self getTradeHistory:[dic objectForKey:@"coin"] withPage:[[dic objectForKey:@"page"] integerValue] withPageCount:[[dic objectForKey:@"size"] integerValue] withResult:^(NSArray<BKTradeItemModel *> *arr, NSInteger count) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_getFees])//获取币种手续费
    {
        BKTransferFeeModel* feeMode = [[BKTransferFeeModel alloc] init];
        feeMode.coin = [dic objectForKey:@"coin"];
        feeMode.from = [dic objectForKey:@"from"];
        feeMode.to = [dic objectForKey:@"to"];
        feeMode.amount = [NSString stringWithFormat:@"%lf",[[dic objectForKey:@"amount"] doubleValue]];
        [self getCoinFee:feeMode withResult:^(NSArray<BKCoinFeeModel *> * arr) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_changePassword])//更改密码
    {
        [self setPayPassword:[dic objectForKey:@"password"] withResult:^(BOOL bl) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    else if([[dic objectForKey:@"action"] isEqualToString:JSBRIDGE_ACTION_resetPassword])//重置密码
    {
        [self setPayPassword:[dic objectForKey:@"password"] withResult:^(BOOL bl) {
            
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
    
}

/**
 TODO:登录SDK
 
 @param uId 第三方userId
 @param result 登录的结果 YES成功，NO失败
 @param error 错误的信息
 */
- (void)initWithUserId:(NSString*)uId withResult:(void(^)(BOOL))result withFail:(void (^)(BKErrorModel*))error
{
    
    
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"crash.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"crash有需要发起请求 降日志传到服务器");
        [self uploadLog];
    }
    
    
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [dicT setValue:[BKCore sharedInstance].coreConfig.appId forKey:@"appId"];
    [dicT setValue:uId forKey:@"appUserId"];
    if(self.coreConfig.logLevel==BKLogLevelDebug)
    {
        DLog(@"开始初始化sdk");
    }
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_API_AUTH] parameters:dicT success:^(NSDictionary *dic) {
        
        
        @try {
            if([[dic objectForKey:@"status"] intValue]==0)
            {
                self.token = [[dic objectForKey:@"data"] objectForKey:@"token"];
                
                if(self.token.length>0)
                {
                    [[NSUserDefaults standardUserDefaults]setObject:self.token forKey:@"ACCESS_TOKEN"];//单独存储一份token
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    _blockBridge(dic,JSBRIDGE_ACTION_initSdk);
                    
                    
                }
                else
                {
                   _blockBridge(dic,JSBRIDGE_ACTION_initSdk);
                }
                
            }
            else
            {
                BKErrorModel* err = [[BKErrorModel alloc] init];
                err.status = [[dic objectForKey:@"status"] integerValue];
                err.msg = [dic objectForKey:@"msg"];
                _blockBridge(dic,JSBRIDGE_ACTION_initSdk);
            }
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"登录SDK exception: %@", exception.reason);
            }
            
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            
        }
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
    
}
/**
 TODO:获取钱包总余额
 
 @param balance 钱包的余额
 @param error 错误的信息
 */
- (void)getTotalBalance:(void (^)(BKBalanceModel *))balance withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_WALLET_TOTAL] parameters:dicT success:^(NSDictionary *dic) {
        
        @try {
            if([[dic objectForKey:@"status"] intValue]==0)
            {
                _blockBridge(dic,JSBRIDGE_ACTION_getBalance);
                
            }
            else
            {
                _blockBridge(dic,JSBRIDGE_ACTION_getBalance);
            }
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"获取钱包总余额抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
    
}

/**
 TODO:获取某一币种的详情
 
 @param code 币种的类型（BTC,ETH...）
 @param coin 返回的币种详情
 @param error 错误的信息
 */
- (void)getCodeDetail:(NSString*)code withResult:(void (^)(BKCoinModel*))coin withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:code forKey:@"coin"];
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_COIN_DETAIL] parameters:dic success:^(NSDictionary *dic) {
        
            
            
            @try{
                _blockBridge(dic,JSBRIDGE_ACTION_getCoinDetail);
            }
            @catch (NSException *exception) {
                //处理异常
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    NSLog(@"获取币种详情抛出异常 exception: %@", exception.reason);
                }
            }
            @finally {
                //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
                
            }
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
    
}

/**
 TODO:获取币种的默认列表
 
 @param type   all所有币种, default默认币种
 @param page 当前页数
 @param pageCount 每一页数的数量
 @param array 币种的默认列表,列表的总数
 @param error 错误的信息
 */

- (void)getCoinsWithType:(NSString*)type withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(NSArray<BKCoinDetailModel*> *,NSInteger))array withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:type forKey:@"type"];
    [dic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"size"];
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_API_COINS] parameters:dic success:^(NSDictionary *dic) {
        
            
            
            @try {
                if([type isEqualToString:@"all"])
                {
                    _blockBridge(dic,JSBRIDGE_ACTION_getCoinList);
                    
                }
                else
                {
                    _blockBridge(dic,JSBRIDGE_ACTION_getCoinList);
                }
                
            }
            @catch (NSException *exception) {
                //处理异常
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    NSLog(@"获取币种列表抛出异常 exception: %@", exception.reason);
                }
            }
            @finally {
                //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
                NSLog(@"finally");
            }
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 搜索币种
 
 @param coin 币种符号（ETH,BTC）
 @param coinDetail 币的详情
 @param error 错误的信息
 */
- (void)searchCoinWithType:(NSString*)coin withResult:(void (^)(BKCoinDetailModel*))coinDetail withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:coin forKey:@"coin"];
    
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_coin_search] parameters:dic success:^(NSDictionary *dic) {
        
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_searchCoin);
            
        }
            @catch (NSException *exception) {
                //处理异常
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
                }
            }
            @finally {
                //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
                NSLog(@"finally");
            }
       
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 TODO:添加币种到默认列表
 
 @param coinId 币种的id
 @param result 添加的结果
 @param error 错误的信息
 */
- (void)addCoins:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error
{
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:coinId forKey:@"coinId"];
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_BK_COIN_ADD] parameters:dic success:^(NSDictionary *dic) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_addCoin);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 删除币种
 
 @param coinId 币种id
 @param result 成功还是失败
 @param error 错误的信息
 */
- (void)deleteCoin:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [dicT setValue:coinId forKey:@"coinId"];
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_COIN_DELETE] parameters:dicT success:^(NSDictionary *dic) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_delCoin);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 TODO:获取指定币种的交易记录
 
 @param code 币种代码（BTC ETH）
 @param page 当前页数
 @param pageCount 每一页数的数量
 @param tradeHistory 转账的记录
 @param error 错误的信息
 */

- (void)getTradeHistory:(NSString*)code withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(NSArray<BKTradeItemModel*>* ,NSInteger))tradeHistory withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dicPar = [[NSMutableDictionary alloc] init];
    [dicPar setValue:code forKey:@"coin"];
    [dicPar setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [dicPar setValue:[NSString stringWithFormat:@"%ld",pageCount] forKey:@"size"];
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_TRANSFER_HISTORY] parameters:dicPar success:^(NSDictionary *dic) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_getTrades);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 获取手续费
 
 @param transferInfo 转账的详情
 @param arrCoinFee 返回的手续费
 @param error 错误的信息
 */
- (void)getCoinFee:(BKTransferFeeModel*)transferInfo withResult:(void (^)(NSArray<BKCoinFeeModel *>*))arrCoinFee withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:transferInfo.coin forKey:@"coin"];
    [dic setValue:transferInfo.from forKey:@"from"];
    [dic setValue:transferInfo.to forKey:@"to"];
    [dic setValue:transferInfo.amount forKey:@"amount"];
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_TRANSFER_FEE] parameters:dic success:^(NSDictionary *dicT) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_getFees);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 转账功能
 
 @param transferModel 传入的转账类型model
 @param result 转账的结果
 @param error 错误的信息
 */
- (void)transferAccount:(BKTransferModel*)transferModel withResult:(void (^)(BKTransferResultModel *))result withFail:(void (^)(BKErrorModel*))error
{
    
}
/**
 TODO:设置支付密码
 
 @param password 支付密码
 @param error 错误的信息
 */

- (void)setPayPassword:(NSString*)password withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [dicT setValue:[BKToolsCO SHA256:password] forKey:@"password"];
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_SETTING_PASSWORD] parameters:dicT success:^(NSDictionary *dic) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_resetPassword);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}

/**
 重置支付密码
 
 @param password 支付密码
 @param result 返回信息 yes成功
 @param error 错误的信息
 */

- (void)resetPayPassword:(NSString*)password withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error
{
    NSMutableDictionary* dicT = [[NSMutableDictionary alloc] init];
    [dicT setValue:[BKToolsCO SHA256:password] forKey:@"password"];
    
    [BKNetWorkHelperCO postWithUrlString:[NSString stringWithFormat:@"%@%@",WEB_API_URL,API_BK_SETTING_PASSWORD] parameters:dicT success:^(NSDictionary *dic) {
        @try {
            _blockBridge(dic,JSBRIDGE_ACTION_resetPassword);
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"搜索币种列表抛出异常 exception: %@", exception.reason);
            }
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
            NSLog(@"finally");
        }
        
        
    } failure:^(NSError *errorCode) {
        BKErrorModel* err = [[BKErrorModel alloc] init];
        err.status = 10000;
        err.msg = @"网络异常";
        error(err);
    }];
}
/**
 设置语言
 
 @param language en cn
 */
- (void)setLanguage:(NSString*)language
{
    self.coreConfig.language = language;
}


/**
 设置法币类型
 
 @param curry usd cny
 */
- (void)setCurry:(NSString *)curry
{
    self.coreConfig.currency = curry;
}


@end
