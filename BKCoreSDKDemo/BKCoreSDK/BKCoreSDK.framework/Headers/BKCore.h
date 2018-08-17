//
//  BKCore.h
//  BKCore
//
//  Created by wxl on 2018/7/2.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKCoreConfig.h"
#import "BKCoinModel.h"
#import "BKBaseCoinModel.h"
#import "BKTradeHistory.h"
#import "BKCoinFeeModel.h"
#import "BKBalanceModel.h"
#import "BKTransferModel.h"
#import "BKTransferResultModel.h"
#import "BKErrorModel.h"
#import "BKCoinDetailModel.h"
#import "BKTransferFeeModel.h"



@interface BKCore : NSObject

/**
 SDK当前版本号
 */
@property (strong, nonatomic, readonly) NSString* sdkVersion;


/**
 SDK的配置信息
 */
@property (strong, nonatomic) BKCoreConfig* coreConfig;


/**
 对象的单例
 
 @return 返回一个单例对象
 */
+ (BKCore *)sharedInstance;



/**
 登录SDK

 @param uId 第三方userId
 @param result 登录的结果 YES成功，NO失败
 @param error 错误的信息
 */
- (void)initWithUserId:(NSString*)uId withResult:(void(^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;


/**
 登出sdk
 */
- (void)logoutSDK;


/**
 获取某一币种的详情

 @param code 币种的类型（BTC,ETH...）
 @param coin 返回的币种详情
 @param error 错误的信息
 */
- (void)getCodeDetail:(NSString*)code withResult:(void (^)(BKCoinModel*))coin withFail:(void (^)(BKErrorModel*))error;


/**
 TODO:获取币种的默认列表
 
 @param type   all所有币种, default默认币种
 @param page 当前页数
 @param pageCount 每一页数的数量
 @param array 币种的默认列表,列表的总数
 @param error 错误的信息
 */

- (void)getCoinsWithType:(NSString*)type withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(NSArray<BKCoinDetailModel*> *,NSInteger))array withFail:(void (^)(BKErrorModel*))error;



/**
 搜索币种

 @param coin 币种符号（ETH,BTC）
 @param coinDetail 币的详情
 @param error 错误的信息
 */
- (void)searchCoinWithType:(NSString*)coin withResult:(void (^)(NSMutableArray<BKCoinDetailModel*>*))coinDetail withFail:(void (^)(BKErrorModel*))error;


/**
 添加币种到默认列表

 @param coinId 币种的id
 @param result 添加的结果
 @param error 错误的信息
 */
- (void)addCoins:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;


/**
 删除币种

 @param coinId 币种id
 @param result 成功还是失败
 @param error 错误的信息
 */
- (void)deleteCoin:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;



/**
 获取指定币种的交易记录

 @param code 币种代码（BTC ETH）
 @param page 当前页数
 @param pageCount 每一页数的数量    最小5条  最大 100 条 默认10条
 @param tradeHistory 转账的记录
 @param error 错误的信息
 */

- (void)getTradeHistory:(NSString*)code withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(NSArray<BKTradeItemModel*>* ,NSInteger))tradeHistory withFail:(void (^)(BKErrorModel*))error;




/**
 获取手续费

 @param transferInfo 转账的详情
 @param arrCoinFee 返回的手续费
 @param error 错误的信息
 */
- (void)getCoinFee:(BKTransferFeeModel*)transferInfo withResult:(void (^)(NSArray<BKCoinFeeModel*>*))arrCoinFee withFail:(void (^)(BKErrorModel*))error;


/**
 获取钱包总余额

 @param balance 钱包的余额
 @param error 错误的信息
 */
- (void)getTotalBalance:(void (^)(BKBalanceModel *))balance withFail:(void (^)(BKErrorModel*))error;



/**
 设置支付密码

 @param password 支付密码
 @param error 错误的信息
 */

- (void)setPayPassword:(NSString*)password withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;


/**
 重置支付密码

 @param password 支付密码
 @param result 返回信息 yes成功
 @param error 错误的信息
 */
- (void)resetPayPassword:(NSString*)password withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;

/**
 设置语言

 @param language en cn
 */
- (void)setLanguage:(NSString*)language;

/**
 设置法币类型

 @param curry usd cny
 */
- (void)setCurry:(NSString*)curry;
@end
