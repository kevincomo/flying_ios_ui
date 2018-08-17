//
//  configure.h
//  ZCFProduct
//
//  Created by wxl on 2018/5/3.
//  Copyright © 2018年 wxl. All rights reserved.
//

#ifndef configure_h
#define configure_h




#define WEB_API_URL         ([[BKCore sharedInstance].coreConfig.environment isEqualToString:@"dev"]?@"http://open.naodui.com":@"https://open.bitkeep.com")

//#define WEB_API_URL         ([[BKCore sharedInstance].coreConfig.environment isEqualToString:@"dev"]?@"http://dev.bitkeep.com:50118":@"https://open.bitkeep.com")



//#define WEB_API_URL @"https://api.lesscloud.com/api/Book"


#define DEBUG_API_ROOT_URL  @"http://open.naodui.com/"

#define RESLEASE_API_ROOT_URL @"https://open.bitkeep.com"


//TODO:初始化SDK
#define API_BK_API_AUTH       @"/api/auth"

//TODO:获取默认币种列表
#define API_BK_API_COINS           @"/api/coins"

//TODO:钱包总额
#define API_BK_WALLET_TOTAL    @"/wallet/total"

//TODO:币列表数据
#define API_BK_API_COINS       @"/api/coins"

//TODO:货币详情
#define API_BK_COIN_DETAIL         @"/coin/detail"

//TODO:该币种流水
#define API_BK_TRANSFER_HISTORY    @"/transfer/history"

//TODO:转账
#define API_BK_TRANSFER_CREATE     @"/transfer/create"

//TODO:手续费获取
#define API_BK_TRANSFER_FEE        @"/transfer/fee"

//TODO:添加币种
#define API_BK_BK_COIN_ADD         @"/coin/add"

//TODO:删除币种
#define API_BK_COIN_DELETE         @"/coin/delete"

//TODO:设置密码
#define API_BK_SETTING_PASSWORD  @"/settings/password"

//TODO:客户端日志接口
#define API_BK_API_LOG          @"/api/log"

//TODO:
#define API_BK_coin_search     @"/coin/search"





/*===========================H5交互 start======================================*/




//初始化sdk（登录sdk）
#define JSBRIDGE_ACTION_initSdk    @"initSdk"

//切换登录用户
#define JSBRIDGE_ACTION_changeUser    @"changeUser"

//移除用户登录信息
#define JSBRIDGE_ACTION_removeUser    @"removeUser"

//获取用户当前币种的详情
#define JSBRIDGE_ACTION_getCoinDetail   @"getCoinDetail"

//获取用户币种列表(选中的)
#define JSBRIDGE_ACTION_getUserCoinList     @"getUserCoinList"

//获取所有币种列表
#define JSBRIDGE_ACTION_getCoinList     @"getCoinList"

//添加币种
#define JSBRIDGE_ACTION_addCoin         @"addCoin"

//删除币种
#define JSBRIDGE_ACTION_delCoin         @"delCoin"

//搜索币种
#define JSBRIDGE_ACTION_searchCoin          @"searchCoin"

//获取当前币种交易详情
#define JSBRIDGE_ACTION_getTrades       @"getTrades"

//获取手续费
#define JSBRIDGE_ACTION_getFees             @"getFees"

//转账
#define JSBRIDGE_ACTION_transfer        @"transfer"

//获取钱包总余额
#define JSBRIDGE_ACTION_getBalance      @"getBalance"

//更改密码
#define JSBRIDGE_ACTION_changePassword      @"changePassword"

//重置密码
#define JSBRIDGE_ACTION_resetPassword       @"resetPassword"



/*===========================H5交互 end======================================*/

#endif /* configure_h */
