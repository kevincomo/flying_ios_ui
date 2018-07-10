//
//  BKKeyboardView.h
//  BitKeep_SDK
//
//  Created by wxl on 2018/6/30.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKTransferModel.h"
#import "BKErrorModel.h"
#import "BKPayResultModel.h"



@interface BKKeyboardView : UIView




/**
 转账支付生成的界面

 @param transfer 需要支付的币种信息
 @param view 展示的view
 @param result 结果
 @param error 错误编码
 @return 实例
 */
- (id)initWithRechargeTransfer:(BKTransferModel*)transfer showInView:(UIView*)view withResult:(void(^)(BKPayResultModel*))result withFail:(void (^)(BKErrorModel*))error;



@end
