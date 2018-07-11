//
//  AppDelegate.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "AppDelegate.h"
#import "BKTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BKCoreConfig* coreConfig = [[BKCoreConfig alloc] init];
    coreConfig.appId = @"9AaqlPy7XStgcm4jzWdFKEnJfCMrGxeZ";
    coreConfig.language = @"cn";
    coreConfig.currency = @"usd";
    coreConfig.secretKey = @"D0UFVymvzkQETmxQuIDJFOHgJGqvwe6MdWL1PoxzZoORs8Xj5Scrb7KPnhu04AhM";
    coreConfig.uId = @"第三方平台自己的id";
    coreConfig.usingHttps = NO; //是否使用https 默认使用 YES
    coreConfig.logLevel = BKLogLevelDebug;


//    ==============不对外================
//    coreConfig.brandName = @"品牌名称";
//    coreConfig.brandModle = @"手机型号";
//    coreConfig.sysVersion = @"手机系统版本";
//    coreConfig.packName = @"android 包名  iOS bId";
//    coreConfig.sdkVersion = @"1.0.0;
//    ==============不对外================
    [BKCore sharedInstance].coreConfig = coreConfig;
    
    
    [[BKCore sharedInstance] initWithUserId:@"123" withResult:^(BOOL bl) {
        if(bl)
        {
            NSLog(@"初始化sdk返回成功可以在访问其他接口");
            BKTabBarController* tab = [[BKTabBarController alloc] init];
            self.window.rootViewController = tab;
        }
        
    } withFail:^(BKErrorModel * err) {
        NSLog(@"初始化sdk返回失败重新请求");
    }];
    
    
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = NO; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 80.0f; // 输入框距离键盘的距离
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
