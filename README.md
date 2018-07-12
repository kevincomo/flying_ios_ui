# flying_sdk_ios
##  下载BKCoreSDK.framework 或者将demo中BKCoreSDK.framework添加到自己的工程中，导入头文件 #import <BKCoreSDK/BKCoreSDK.h>


## 1.初始化SDK

        设置配置文件
        BKCoreConfig* coreConfig = [[BKCoreConfig alloc] init];
        coreConfig.appId = @"后台生成的id";
        coreConfig.language = @"中文cn，英文传入en";
        coreConfig.currecy = @"人民币cny，美元usd";
        coreConfig.secretKey = @"后台生成的secret";
        coreConfig.uId = @"第三方平台自己的id";                 /
        coreConfig.usingHttps = YES; //是否使用https 默认使用 YES
        coreConfig.enableConsoleLog = @"控制台是否输出日志，默认不输出"；
        coreConfig.logLevel = @"日志输出级别";

        [BKCore sharedInstance].coreConfig = coreConfig;

## 2.登录SDK
        /**
        登录SDK

        @param uId 第三方userId
        @param result 登录的结果 YES成功，NO失败
        @param error 错误的信息
        */
        - (void)initWithUserId:(NSString*)uId withResult:(void(^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;

## 3.获取币详情里面包含的数据(该币种的余额， 价格，地址)

        /**
        获取某一币种的详情

        @param code 币种的类型（BTC,ETH...）
        @param coin 返回的币种详情
        @param error 错误的信息
        */

        - (void)getCodeDetail:(NSString*)code withResult:(void (^)(BKCoinModel*))coin withFail:(void (^)(BKErrorModel*))error;

        BKCoinModel: address   钱包地址
                     balance   币种余额
                     price          币种价格



        //调用方法
        [[BKCore sharedInstance] getCodeDetail:@"BTC" withResult:^(BKCoinModel* coin){
        //返回的币种详情 BKCoinModel

        } withFail:^(BKErrorModel* error){
        //返回的错误码（错误码对照表）
        }];


## 4.获取用户展示的已有或者已添加的货币列表


        /**
        TODO:获取币种的默认列表

        @param type   all所有币种, default默认币种
        @param page 当前页数
        @param pageCount 每一页数的数量
        @param array 币种的默认列表,列表的总数
        @param error 错误的信息
        */

        - (void)getCoinsWithType:(NSString*)type withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(NSArray<BKCoinDetailModel*> *,NSInteger))array withFail:(void (^)(BKErrorModel*))error;


        //调用方法
        [[BKCore sharedInstance] getCoinsWithType:@"default" withPage:page withPageCount:pageNumber withResult:^(NSArray<BKCoinDetailModel *> * arr, NSInteger total) {

        } withFail:^(BKErrorModel * err) {

        }];

## 5. 添加币种

        /**
        添加币种到默认列表

        @param coinId 币种的id
        @param result 添加的结果
        @param error 错误的信息
        */
        - (void)addCoins:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;


        //调用方法
        [[BKCore sharedInstance] addCoins:@"1111111" withResult:^(BOOL  bl){
        //返回的YES or NO
        } withFail:^(BKErrorModel* error){
        //返回的错误码（错误码对照表）
        }];


## 6.获取当前账户的某一币种的交易记录

        /**
        获取指定币种的交易记录

        @param code 币种代码（BTC ETH）
        @param page 当前页数
        @param pageCount 每一页数的数量
        @param tradeHistory 转账的记录
        @param error 错误的信息
        */

        - (void)getTradeHistory:(NSString*)code withPage:(NSInteger)page withPageCount:(NSInteger)pageCount withResult:(void (^)(BKTradeHistory *))tradeHistory withFail:(void (^)                 (BKErrorModel*))error;

        BKTradeHistory：pageTotalCount  总条数
        NSArray* list
        BKTradeItemModel：type    1转账 2 充值
        time   转账时间
        amount   转账金额
        tId   转账id

        //调用方法
        [[BKCore sharedInstance] getTradeHistory:@"BTC" withPage:1 withPageCount:10 withResult:^(BKTradeHistory* trade){
        //返回BKTradeHistory
        } withFail:^(BKErrorModel* error){
        //返回的错误码（错误码对照表）
        }];



## 7.根据转币数量获取手续费的收取(免费或者bkb或者转出的币种)

        /**
        获取手续费

        @param transferInfo 转账的详情
        @param coinFee 返回的手续费
        @param error 错误的信息
        */
        - (void)getCoinFee:(BKTransferFeeModel*)transferInfo withResult:(void (^)(BKCoinFeeModel *))coinFee withFail:(void (^)(BKErrorModel*))error;

        transferInfo：coin  币种
        from  转出地址
        to     转入地址
        amount  转账金额

        BKCoinFeeModel：fee_text   手续费文案
        fee_id   手续费id


        //调用方法
        [[BKCore sharedInstance] getCoinFee:@"转账的信息"  withResult:^(BKCoinFeeModel* fee){
        //返回BKCoinFeeModel
        } withFail:^(BKErrorModel* error){
        //返回的错误码（错误码对照表）
        }];



## 8.获取当前用户可用的余额（根据币种换算得到法币的价格，钱包的总法币价值）
        /**
        获取钱包总余额

        @param balance 钱包的余额
        @param error 错误的信息
        */
        - (void)getTotalBalance:(void (^)(BKBalanceModel *))balance withFail:(void (^)(BKErrorModel*))error;

        BKBalanceModel： amount   总余额

        //调用方法
        [[BKCore sharedInstance] getTotalBalance:^(BKBalanceModel * balance) {
        //返回BKBalanceModel

        } withFail:^(BKErrorModel * error) {
        //返回的错误码（错误码对照表）
        }]



## 9. 转账
        /**
        转账支付生成的界面

        @param recharge 需要支付的币种信息
        @param view 展示的view
        @param result 结果
        @param error 错误编码
        @return 实例
        */
        - (id)initWithRechargeTransfer:(BKTransferModel*)recharge showInView:(UIView*)view withResult:(void(^)(BKPayResultModel*))result withFail:(void (^)(BKErrorModel*))error;


        BKPayResultModel：



        //调用方法
        BKTransferModel* transferModel = [[BKTransferModel alloc] init];
        transferModel.amount = @"1.222";
        transferModel.toAddress = @"提币的地址";
        transferModel.code = @"BKB";
        transferModel.fee_id = @"手续费id";
        transferModel.type = @"1为红包 2为转账";

        BKKeyboardView* keyboard = [[BKKeyboardView alloc] initWithRechargeTransfer:transferModel showInView:self.view withResult:^(BKPayResultModel * result) {

        } withFail:^(BKErrorModel * error) {

        }];


## 10.设置支付密码
        /**
        设置支付密码

        @param password 支付密码
        @param error 错误的信息
        */

        - (void)setPayPassword:(NSString*)password withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error;
        ## 11.删除币种
        /**
        删除币种

        @param coinId 币种id
        @param result 成功还是失败
        @param error 错误的信息
        */
        - (void)deleteCoin:(NSString*)coinId withResult:(void (^)(BOOL))result withFail:(void (^)(BKErrorModel*))error

## 12.设置语言 （客户端自己做）

        /**
        设置语言

        @param language en cn
        */
        - (void)setLanguage:(NSString*)language;


## 13.设置法币的种类 （客户端自己做）
        /**
        设置法币类型

        @param curry usd cny
        */
        - (void)setCurry:(NSString*)curry;





