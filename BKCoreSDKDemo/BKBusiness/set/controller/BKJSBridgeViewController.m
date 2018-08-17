//
//  BKJSBridgeViewController.m
//  BKCoreSDK
//
//  Created by wxl on 2018/7/17.
//  Copyright © 2018年 wxl. All rights reserved.
//

//修改右侧按钮
#define BK_JS_changeRightButton  @"BK://action/changeRightButton"

//修改中部title
#define BK_JS_changeMiddleTitle  @"BK://action/changeMiddleTitle"

//显示进度条
#define BK_JS_showProgress   @"BK://action/showProgress"

//隐藏进度条
#define BK_JS_hideProgress   @"BK://action/hideProgress"

//关闭当前界面
#define BK_JS_finish @"BK://action/finish"

//移除右侧按钮
#define BK_JS_removeRightButton  @"BK://action/removeRightButton"

//掉起支付密码
#define BK_JS_callPassBoard  @"BK://action/callPassBoard"


#define is5_8inch_retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 弱引用
#define MJWeakSelf __weak typeof(self) weakSelf = self;

#import "BKJSBridgeViewController.h"
#import "BKButton.h"

#import "BKJsBridgeCore.h"




@interface BKJSBridgeViewController ()
{
}

@property (strong, nonatomic) UIProgressView* progressView;
@property (strong, nonatomic) WKWebView* webView;

@end

@implementation BKJSBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = NO;
    // **************** 此处划重点 **************** //
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences = [[WKPreferences alloc] init];
    
    config.preferences.minimumFontSize = 10;
    
    config.preferences.javaScriptEnabled = YES;
    
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    config.userContentController = [[WKUserContentController alloc] init];
    
    config.processPool = [[WKProcessPool alloc] init];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame
                    
                                      configuration:config];
    
    //记得实现对应协议,不然方法不会实现.
    
    self.webView.UIDelegate = (id)self;
    
    self.webView.navigationDelegate = (id)self;
    
    [self.view addSubview:self.webView];
    //添加注入js方法, oc与js端对应实现
    
    [config.userContentController addScriptMessageHandler:(id)self name:@"call"];
    
    
    //js端代码实现实例(此处为js端实现代码给大家粘出来示范的!!!):
    
    [self addProgress];
    
    
//    if(![_url hasPrefix:@"http"])
//    {
//        _url = [NSString stringWithFormat:@"http://%@",_url];
//    }
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
//
//    [_webView loadRequest:request];
    
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"redtest.html" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
        [self.webView loadRequest:request];
 
}


#pragma mark 添加加载条
- (void)addProgress
{
    
    // KVO，监听webView属性值得变化(estimatedProgress,title为特定的key)
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 64, self.webView.frame.size.width, 2);
    if(is5_8inch_retina)
    {
        self.progressView.frame = CGRectMake(0, 88, self.webView.frame.size.width, 2);
    }
    self.progressView.trackTintColor = [UIColor clearColor]; // 设置进度条的色彩
    self.progressView.progressTintColor = [UIColor magentaColor];
    // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    [self.progressView setProgress:0.1 animated:YES];
    [self.webView addSubview:self.progressView];
}

// TODO:当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    //添加localStorage
    NSString *jsString = [NSString stringWithFormat:@"window.localStorage.setItem('bk_token','%@')",[[NSUserDefaults standardUserDefaults] objectForKey:@"ACCESS_TOKEN"]];
    // 移除localStorage
    // NSString *jsString = @"localStorage.removeItem('userContent')";
    // 获取localStorage
    // NSString *getJsString = @"localStorage.getItem('userContent')";
    [self.webView evaluateJavaScript:jsString completionHandler:^(_Nullable id dic, NSError * _Nullable error){
        if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
        {
            NSLog(@"======写入localStorage开始");
            NSLog(@"======写入localStorage失败：%@",error);
        }
        
    }];
}
#pragma mark - WKScriptMessageHandler

//实现js注入方法的协议方法

- (void)userContentController:(WKUserContentController *)userContentController

      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    MJWeakSelf;
    //找到对应js端的方法名,获取messge.body
    if ([message.name isEqualToString:@"call"]) {
        NSLog(@"%@,%@", message.body,message.webView.URL);
       
        @try {
            if([message.body hasPrefix:@"BK://"])
            {
                [self typeAction:message.body];
            }
            else
            {
                [BKJsBridgeCore sharedInstance].blockBridge = ^(NSDictionary* dicPra, NSString* strActi){
                    [weakSelf.webView evaluateJavaScript:[NSString stringWithFormat:@"bkMessage('%@','%@')",strActi,dicPra] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                        if([BKJsBridgeCore sharedInstance].logLevel==BKLogLevelDebug)
//                        {
//                            NSLog(@"token返回成功");
//                        }
                        
                    }];
                    NSLog(@"===============");
                };
                [[BKJsBridgeCore sharedInstance] typeAction:message.body];
            }
            
        }
        @catch (NSException *exception) {
            //处理异常
            if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
            {
                NSLog(@"=========js回调抛出异常exception: %@", exception.reason);
            }
            
        }
        @finally {
            //finally代码块是可选的，如果写了，不管有没有异常，block内的代码都会被执行
        }
        
    }
    
}

- (void)typeAction:(NSString*)str
{
    NSArray *arrFucnameAndParameter = [(NSString*)str componentsSeparatedByString:@"?"];
    
    if([str hasPrefix:BK_JS_changeRightButton])//修改右侧按钮
    {
        [self setNavigationBarRightItemWithTitle:[arrFucnameAndParameter objectAtIndex:1]];
    }
    else if([str hasPrefix:BK_JS_changeMiddleTitle])//更改中央标题
    {
        NSArray *arr = [[arrFucnameAndParameter objectAtIndex:1] componentsSeparatedByString:@"&"];
        NSLog(@"%@",[self URLDecodedString:[arr objectAtIndex:2]]);
        
        
        self.navigationItem.title = [[[arr objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
     
        
        NSString *strColor = [[[[self URLDecodedString:[arr objectAtIndex:2]] componentsSeparatedByString:@"="] objectAtIndex:1] stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [self colorWithHexString:strColor alpha:1.0],
                                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:[[[[arr objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:1] intValue]]}];
    }
    else if([str hasPrefix:BK_JS_showProgress])//展示进度条
    {
        
    }
    else if([str hasPrefix:BK_JS_hideProgress])//隐藏进度条
    {
        
    }
    else if([str hasPrefix:BK_JS_finish])//关闭当前页
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else if([str hasPrefix:BK_JS_removeRightButton])//移除右侧按钮
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if([str hasPrefix:BK_JS_callPassBoard])//调用密码支付界面
    {
        [self callPay:[arrFucnameAndParameter objectAtIndex:1]];
    }
}

#pragma mark 字符串十六进制图片
- (UIColor*)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{

    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    UIColor *defaultColor = [UIColor clearColor];

    if (hexString.length < 6) return defaultColor;
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if ([hexString hasPrefix:@"0x"]) hexString = [hexString substringFromIndex:2];
   // if (hexString.length != 6) return defaultColor;

    //method1
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) return defaultColor;

    //method2
    const char *char_str = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    int hexNum;
    sscanf(char_str, "%x", &hexNum);

    return [self colorWithHex:hexNumber alpha:alpha];
}
- (UIColor*)colorWithHex:(int)hexNumber alpha:(CGFloat)alpha{
    
    if (hexNumber > 0xFFFFFF) return nil;
    
    CGFloat red   = ((hexNumber >> 16) & 0xFF) / 255.0;
    CGFloat green = ((hexNumber >> 8) & 0xFF) / 255.0;
    CGFloat blue  = (hexNumber & 0xFF) / 255.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return color;
    
}




- (void)dealloc {
    
    // 最后一步：移除监听
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}
#pragma mark - KVO监听
// 第三部：完成监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:self.webView] && [keyPath isEqualToString:@"estimatedProgress"]) { // 进度条
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        
        if (newprogress == 1) { // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
            
        } else { // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if ([object isEqual:self.webView] && [keyPath isEqualToString:@"title"]) { // 标题
        
        self.title = self.webView.title;
    } else { // 其他
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString:(NSString*)str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString:(NSString*)str
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = str;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}



/**
 * 根据文字设定右侧按钮
 */
- (void)setNavigationBarRightItemWithTitle:(NSString *)title{
    
    NSArray *arr = [title componentsSeparatedByString:@"&"];
    NSLog(@"%@",[self URLDecodedString:[arr objectAtIndex:2]]);
    
    

    
    
    BKButton* btn = [BKButton buttonWithType:0];
    [btn setTitle:[[[arr objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1] forState:0];
    [btn setFrame:CGRectMake(0, 0, 44, 44)];
    btn.titleLabel.font = [UIFont systemFontOfSize:[[[[arr objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:1] intValue]];
    
    NSString *strColor = [[[[self URLDecodedString:[arr objectAtIndex:2]] componentsSeparatedByString:@"="] objectAtIndex:1] stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
                        
    [btn setTitleColor:[self colorWithHexString:strColor alpha:1.0] forState:0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self action:@selector(fs_rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    btn.strURL = [[[arr objectAtIndex:3] componentsSeparatedByString:@"="] objectAtIndex:1];
}

#pragma mark 掉起支付密码
- (void)callPay:(NSString*)str
{
    MJWeakSelf;
     NSArray *arr = [str componentsSeparatedByString:@"&"];
    BKTransferModel* transferModel = [[BKTransferModel alloc] init];
    transferModel.from = [[[arr objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
    transferModel.to = [[[arr objectAtIndex:1] componentsSeparatedByString:@"="] objectAtIndex:1];
    transferModel.amount = [[[arr objectAtIndex:2] componentsSeparatedByString:@"="] objectAtIndex:1];
    transferModel.coin = [[[arr objectAtIndex:3] componentsSeparatedByString:@"="] objectAtIndex:1];
    
    [[BKKeyboardView alloc] initWithRechargeTransfer:transferModel showInView:weakSelf.view withResult:^(BKPayResultModel *result) {
        if([result.status integerValue]==0)
        {
            
            [ weakSelf.webView evaluateJavaScript:[NSString stringWithFormat:@"callback(%@)",result.status] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    NSLog(@"=======支付成功，开始回调H5");
                    NSLog(@"=======支付回调H5失败：%@",error);
                }
                
            }];
        }
        else
        {
            [ weakSelf.webView evaluateJavaScript:[NSString stringWithFormat:@"callback(%@)",result.status] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                if([BKCore sharedInstance].coreConfig.logLevel==BKLogLevelDebug)
                {
                    NSLog(@"=======支付失败，开始回调H5");
                    NSLog(@"=======支付回调H5失败：%@",error);
                }
            }];
        }
    } withFail:^(BKErrorModel *error) {
        [ weakSelf.webView evaluateJavaScript:@"callback(sb)" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"===============失败");
        }];
    } withPayType:@"1"];
}
#pragma mark - 右侧按钮点击事件
- (void)fs_rightBtnClick:(BKButton *)sender{
    
    NSString* url = [self URLDecodedString:sender.strURL];
    
    if(![url hasPrefix:@"http"])
    {
        url = [NSString stringWithFormat:@"http://%@",_url];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
