//
//  BKCoinTableViewHeader.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinTableViewHeader.h"

@implementation BKCoinTableViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = HEXCOLOR(0xF3F4F6);
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(0, 0, 750, 252)];
        imageViewBg.backgroundColor = HEXCOLOR(0x5A647B);
        [self addSubview:imageViewBg];
        
        UILabel* labelMoney = [[UILabel alloc] initWithFrame:NEWFRAME(56, 128, 600, 45)];
        
        labelMoney.backgroundColor = [UIColor clearColor];
        labelMoney.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        labelMoney.text = @"钱包金额";
        labelMoney.textColor = HEXCOLOR(0xBFC4D3);
        [self addSubview:labelMoney];
        
        int y = 45+20;
        _labelAmount = [[UILabel alloc] initWithFrame:NEWFRAME(56, y+128, 600, 40)];
        if(is5_8inch_retina)
        {
            labelMoney.frame = NEWFRAME(40, 176, 600, 45);
            _labelAmount.frame = NEWFRAME(40, y+176, 600, 40);
            imageViewBg.frame = NEWFRAME(0, 0, 750, 252+48);
        }
        _labelAmount.backgroundColor = [UIColor clearColor];
        _labelAmount.font = [UIFont boldSystemFontOfSize:FONTNUMBER+5];
        _labelAmount.textColor = HEXCOLOR(0xFFFFFF);
        [self addSubview:_labelAmount];
        
        
        y = 280;
        if(is5_8inch_retina)
        {
            y+=45;
        }
        
        //币种
        UILabel* labelCoinType = [[UILabel alloc] initWithFrame:NEWFRAME(56, y, 600, 45)];
        
        labelCoinType.backgroundColor = [UIColor clearColor];
        labelCoinType.font = [UIFont systemFontOfSize:FONTNUMBER];
        labelCoinType.text = @"币种";
        labelCoinType.textColor = HEXCOLOR(0xBFC4D3);
        [self addSubview:labelCoinType];
        
        
        
        //持有
        UILabel* labelHold = [[UILabel alloc] initWithFrame:NEWFRAME(87*2+28, y, 600, 45)];
        
        labelHold.backgroundColor = [UIColor clearColor];
        labelHold.font = [UIFont systemFontOfSize:FONTNUMBER];
        labelHold.text = @"持有";
        labelHold.textColor = HEXCOLOR(0xBFC4D3);
        [self addSubview:labelHold];
        
        
        //价格
        UILabel* labelPrice = [[UILabel alloc] initWithFrame:NEWFRAME(200*2+28, y, 600, 45)];
        
        labelPrice.backgroundColor = [UIColor clearColor];
        labelPrice.font = [UIFont systemFontOfSize:FONTNUMBER];
        labelPrice.text = @"价格";
        labelPrice.textColor = HEXCOLOR(0xBFC4D3);
        [self addSubview:labelPrice];
        
        
        //地址
        UILabel* labelAddress = [[UILabel alloc] initWithFrame:NEWFRAME(326*2, y, 600, 45)];
        
        labelAddress.backgroundColor = [UIColor clearColor];
        labelAddress.font = [UIFont systemFontOfSize:FONTNUMBER];
        labelAddress.text = @"地址";
        labelAddress.textColor = HEXCOLOR(0xBFC4D3);
        [self addSubview:labelAddress];
    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
