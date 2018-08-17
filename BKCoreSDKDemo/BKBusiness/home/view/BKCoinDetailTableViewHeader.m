//
//  BKCoinDetailTableViewHeader.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinDetailTableViewHeader.h"

@implementation BKCoinDetailTableViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = HEXCOLOR(0xF3F4F6);
        
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(30, 30, 750-60, 270)];
        imageViewBg.backgroundColor = HEXCOLOR(0x7E88A9);
        imageViewBg.layer.cornerRadius = 8.0f;
        imageViewBg.layer.masksToBounds = YES;
        [self addSubview:imageViewBg];
        
        _labelName = [[UILabel alloc] initWithFrame:NEWFRAME(40, 40, 400, 40)];
        _labelName.text = @"BTC金额";
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelName.textColor = [UIColor whiteColor];
        [imageViewBg addSubview:_labelName];
        
        _labelNumber = [[UILabel alloc] initWithFrame:NEWFRAME(40, 80, 400, 40)];
        _labelNumber.text = @"0.0937";
        _labelNumber.backgroundColor = [UIColor clearColor];
        _labelNumber.font = [UIFont boldSystemFontOfSize:FONTNUMBER+4];
        _labelNumber.textColor = [UIColor whiteColor];
        [imageViewBg addSubview:_labelNumber];
        
        _labelAmount = [[UILabel alloc] initWithFrame:NEWFRAME(252, 80, 400, 40)];
        _labelAmount.text = @"￥86.09";
        _labelAmount.backgroundColor = [UIColor clearColor];
        _labelAmount.font = [UIFont boldSystemFontOfSize:FONTNUMBER-1];
        _labelAmount.textColor = [UIColor whiteColor];
        [imageViewBg addSubview:_labelAmount];
        
        UILabel* labelAddressT = [[UILabel alloc] initWithFrame:NEWFRAME(40, 140, 400, 40)];
        labelAddressT.text = @"地址";
        labelAddressT.backgroundColor = [UIColor clearColor];
        labelAddressT.font = [UIFont boldSystemFontOfSize:FONTNUMBER-1];
        labelAddressT.textColor = [UIColor whiteColor];
        [imageViewBg addSubview:labelAddressT];
        
        _labelAddress = [[UILabel alloc] initWithFrame:NEWFRAME(40, 170, 600, 80)];
        _labelAddress.numberOfLines = 0;
        _labelAddress.text = @"0xh7s9fhs98fs9823h8rew9823jdfsk9";
        _labelAddress.backgroundColor = [UIColor clearColor];
        _labelAddress.font = [UIFont boldSystemFontOfSize:FONTNUMBER-1];
        _labelAddress.textColor = [UIColor whiteColor];
        [imageViewBg addSubview:_labelAddress];
        
        
        UILabel* labelDetailed = [[UILabel alloc] initWithFrame:NEWFRAME(40, 330, 400, 40)];
        labelDetailed.text = [BKUtils DPLocalizedString:@"明细"];;
        labelDetailed.backgroundColor = [UIColor clearColor];
        labelDetailed.font = [UIFont boldSystemFontOfSize:FONTNUMBER-1];
        labelDetailed.textColor = HEXCOLOR(0x9DA2B1);
        [self addSubview:labelDetailed];
        
    }
    return self;
}

- (void)setCoinDetailModel:(BKCoinDetailModel *)coinDetailModel
{
    _coinDetailModel = coinDetailModel;
    _labelAddress.text = coinDetailModel.address;
    
    if([[BKCore sharedInstance].coreConfig.currency isEqualToString:@"cny"]) {
        _labelAmount.text = [NSString stringWithFormat:@"￥：%@",coinDetailModel.price];
    } else {
        _labelAmount.text = [NSString stringWithFormat:@"$：%@",coinDetailModel.price];
    }
    
    _labelNumber.text = coinDetailModel.amount;
    _labelName.text = [NSString stringWithFormat:@"%@金额",coinDetailModel.name];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
