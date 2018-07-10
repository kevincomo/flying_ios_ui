//
//  ViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BKTransferModel* transfer = [[BKTransferModel alloc] init];
    transfer.coin = @"BKB";
    transfer.amount = @"12222";
    BKKeyboardView* key = [[BKKeyboardView alloc] initWithRechargeTransfer:transfer showInView:self.view withResult:^(BKPayResultModel *result) {
        
    } withFail:^(BKErrorModel *error) {
        
    }];
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
