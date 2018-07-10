//
//  BKCoinDetailTableViewCell.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCoinDetailTableViewCell : UITableViewCell

//icon
@property (strong, nonatomic) UIImageView* imageViewIcon;

//行为名称
@property (strong, nonatomic) UILabel* labelActivityName;

//时间
@property (strong, nonatomic) UILabel* labelTime;

//资产的多少
@property (strong, nonatomic) UILabel* labelAmount;


@property (strong, nonatomic) BKTradeItemModel* tradeItemModel;

@end
