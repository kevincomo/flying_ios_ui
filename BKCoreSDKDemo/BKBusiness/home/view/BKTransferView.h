//
//  BKTransferView.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCoinFeeSecModel.h"


@interface BKTransferView : UIView

@property (strong, nonatomic) BKCoinDetailModel* coinDetailModel;


//转出的地址
@property (copy, nonatomic) void(^blockAdress)(NSString*);


//转出的数量
@property (copy, nonatomic) void(^blockAmount)(NSString*);


@property (copy, nonatomic) void(^blockCoinFee)(BKCoinFeeSecModel*);


@property (copy, nonatomic) void(^blockTransfer)(void);

@property (copy, nonatomic) void(^blockQC)(void);

@property (copy, nonatomic) NSArray* arrFee;

@end
