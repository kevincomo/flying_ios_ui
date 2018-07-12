//
//  BKTransferViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKTransferViewController.h"
#import "BKTransferView.h"
#import "BKCoinFeeSecModel.h"
#import "WBQRCodeScanningVC.h"
#import "WCQRCodeScanningVC.h"
#import <AVFoundation/AVFoundation.h>

@interface BKTransferViewController ()
{
    BKTransferView* transferView;
}
@end

@implementation BKTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:NOTICE_GET_QC object:nil];
    
    [self.customNavTitleLabel setText:[BKUtils DPLocalizedString:@"转账"]];
    [self addView];
    
#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)addView
{
    MJWeakSelf;
    transferView = [[BKTransferView alloc] initWithFrame:NEWFRAME(0, 0, 750, 1334-44)];
    
    //转入数量回调
    transferView.blockAmount = ^(NSString *amount) {
        weakSelf.transferModel.amount = amount;
    };
    
    //转入地址回调
    transferView.blockAdress = ^(NSString *address) {
        weakSelf.transferModel.to = address;
    };
    
    //手续费回调
    transferView.blockCoinFee = ^(BKCoinFeeSecModel* coinFeeSecModel){
        weakSelf.transferModel.fee.fee = coinFeeSecModel.fee;
        weakSelf.transferModel.fee.coin = coinFeeSecModel.coin;
    };
    
    //唤起二维码
    transferView.blockQC = ^{
        WBQRCodeScanningVC *WBVC = [[WBQRCodeScanningVC alloc] init];
        WBVC.blockQCString = ^(NSString *str) {
            
        };
        [weakSelf QRCodeScanVC:WBVC];
    };
    
    //开始转账
    transferView.blockTransfer = ^{
        
        [[BKKeyboardView alloc] initWithRechargeTransfer:weakSelf.transferModel showInView:weakSelf.view withResult:^(BKPayResultModel *result) {
            if(result.status==0)
            {
                [BKUtils showSuccessWithStatus:@"转账成功" time:2.0 sucessOrError:2.0];
            }
            else
            {
                [BKUtils showSuccessWithStatus:@"转账失败" time:2.0 sucessOrError:2.0];
            }
        } withFail:^(BKErrorModel *error) {
            NSLog(@"");
        }];
    };
    transferView.coinDetailModel = _coinDetailModel;
    [self.scrollViewBg addSubview:transferView];
}


- (void)setCoinDetailModel:(BKCoinDetailModel *)coinDetailModel
{
    _coinDetailModel = coinDetailModel;
    _transferModel = [[BKTransferModel alloc] init];
    _transferModel.from = coinDetailModel.address;
    _transferModel.type = @"1";//转账
    _transferModel.coin = coinDetailModel.coin;
    [self addView];
}
#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
   
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    if(_transferModel.amount.length>0&&_transferModel.to>0)
    {
        BKTransferFeeModel* fee = [[BKTransferFeeModel alloc] init];
        fee.amount = _transferModel.amount;
        fee.to = _transferModel.to;
        fee.from = _transferModel.from;
        fee.coin = _transferModel.coin;
        [[BKCore sharedInstance] getCoinFee:fee withResult:^(NSArray<BKCoinFeeModel *> *arr) {
            
            NSMutableArray* arrTem = [[NSMutableArray alloc] init];
            for(BKCoinFeeModel* fee in arr)
            {
                BKCoinFeeSecModel* feeSecModel = [[BKCoinFeeSecModel alloc] init];
                feeSecModel.fee = fee.fee;
                feeSecModel.coin = fee.coin;
                feeSecModel.boolSec = NO;
                [arrTem addObject:feeSecModel];
            }
            transferView.arrFee = (NSArray*)arrTem;
        } withFail:^(BKErrorModel *err) {
            
        }];
    }
}

- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}


/**
 通知
 
 @param sender sender descriptio
 */
-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    self.transferModel.to = (NSString*)[sender object];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTICE_GET_QC object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
