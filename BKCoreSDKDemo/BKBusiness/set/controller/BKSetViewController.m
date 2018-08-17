//
//  BKSetViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKSetViewController.h"
#import "BKSetView.h"
#import "BKJSBridgeViewController.h"


@interface BKSetViewController ()

@end

@implementation BKSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftButton.hidden = YES;
    [self addView];
}

- (void)addView
{
    MJWeakSelf;
    BKSetView* setView = [[BKSetView alloc] initWithFrame:NEWFRAME(0, 0, 750, 1334)];
    setView.blockLogout = ^{
//        [[BKCore sharedInstance] logoutSDK];
//        [BKUtils showSuccessWithStatus:@"退出成功" time:2 sucessOrError:2];
//

        BKJSBridgeViewController* jsBridgeVC = [[BKJSBridgeViewController alloc] init];
        jsBridgeVC.url = @"http://10.165.7.91/redtest.html";
        jsBridgeVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:jsBridgeVC animated:YES];
    };
    setView.blockLogIn = ^(NSString * str) {
        BKCoreConfig* coreConfig = [[BKCoreConfig alloc] init];
        coreConfig.appId = @"9AaqlPy7XStgcm4jzWdFKEnJfCMrGxeZ";
        coreConfig.uId = str;
        coreConfig.language = @"en";
        coreConfig.currency = @"cny";
        coreConfig.apiVersion = @"0.0.1";
        coreConfig.secretKey = @"D0UFVymvzkQETmxQuIDJFOHgJGqvwe6MdWL1PoxzZoORs8Xj5Scrb7KPnhu04AhM";
        coreConfig.logLevel = BKLogLevelDebug;
        coreConfig.environment = @"open"; //dev 测试环境  open  发布环境
        
        [BKCore sharedInstance].coreConfig = coreConfig;
        [[BKCore sharedInstance] initWithUserId:str withResult:^(BOOL bl) {
            //登入成功之后处理逻辑
            [BKUtils showSuccessWithStatus:@"登入成功" time:2 sucessOrError:2];
        } withFail:^(BKErrorModel * error) {
            
        }];
    };
    setView.blockPassword = ^(NSString *str) {
        if(str.length!=6)
        {
            [BKUtils showSuccessWithStatus:@"密码必须为六位数字" time:2.0 sucessOrError:2.0];
        }
        else
        {
            [[BKCore sharedInstance] setPayPassword:str withResult:^(BOOL bl) {
                [BKUtils showSuccessWithStatus:@"设置成功" time:2.0 sucessOrError:2.0];
            } withFail:^(BKErrorModel *err) {
                
            }];
        }
        
        
    };
    [self.scrollViewBg addSubview:setView];
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
