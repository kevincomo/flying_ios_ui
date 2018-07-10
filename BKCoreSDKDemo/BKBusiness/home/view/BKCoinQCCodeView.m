//
//  BKCoinQCCodeView.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/6.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinQCCodeView.h"

@implementation BKCoinQCCodeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.userInteractionEnabled = YES;
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
        tapRecognize.delegate = self;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [tapRecognize cancelsTouchesInView];
        
        [self addGestureRecognizer:tapRecognize];
        
        
        
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(96, 280, 750-96*2, 386*2)];
        imageViewBg.backgroundColor = [UIColor whiteColor];
        imageViewBg.layer.cornerRadius = 8.0f;
        imageViewBg.layer.masksToBounds = YES;
        imageViewBg.userInteractionEnabled = YES;
        [self addSubview:imageViewBg];
        
        
        _labelTitle = [[UILabel alloc] initWithFrame:NEWFRAME(0, 80, 750-96*2, 40)];
        _labelTitle.text = @"我的BTC地址";
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.font = [UIFont boldSystemFontOfSize:FONTNUMBER+4];
        _labelTitle.textColor = HEXCOLOR(0x3D4660);
        [imageViewBg addSubview:_labelTitle];
        
        _imageViewQCCode = [[UIImageView alloc] initWithFrame:NEWFRAME((115-48)*2, 150, 750-230*2, 750-230*2)];
        _imageViewQCCode.image = [BKUtils getQCWithString:@"sjdfjsfdlsfjlds"];
        [imageViewBg addSubview:_imageViewQCCode];
        
        _labelAddress = [[UILabel alloc] initWithFrame:NEWFRAME(40, 50+750-230*2+150, 750-96*2-80, 80)];
        _labelAddress.numberOfLines = 0;
        _labelAddress.text = @"hfjsfahjsdhfahsfdsjkfhsdkjhfsdjfksdfhdsjkkj";
        _labelAddress.textAlignment = NSTextAlignmentCenter;
        _labelAddress.backgroundColor = [UIColor clearColor];
        _labelAddress.font = [UIFont boldSystemFontOfSize:FONTNUMBER];
        _labelAddress.textColor = HEXCOLOR(0x3D4660);
        [imageViewBg addSubview:_labelAddress];
        
        //充值
        UIButton* btnRecharge = [UIButton buttonWithType:0];
        [btnRecharge setBackgroundImage:[BKUtils createImageWithColor:HEXCOLOR(0xF3F4F6)] forState:UIControlStateNormal];
        btnRecharge.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER];
        [btnRecharge setBackgroundImage:[BKUtils createImageWithColor:HEXCOLOR(0x5A647B)] forState:UIControlStateHighlighted];
        [btnRecharge setFrame:NEWFRAME(136-96, 386*2-76-40, 224, 76)];
        [btnRecharge setTitle:@"充值" forState:0];
        [btnRecharge setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btnRecharge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btnRecharge.tag = 1;
        [btnRecharge addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnRecharge];
        
        //转账
        UIButton* btnTransfer = [UIButton buttonWithType:0];
        [btnTransfer setBackgroundImage:[BKUtils createImageWithColor:HEXCOLOR(0x5A647B)] forState:UIControlStateNormal];
       // [btnTransfer setBackgroundImage:[BKUtils createImageWithColor:HEXCOLOR(0x5A647B)] forState:UIControlStateHighlighted];
        [btnTransfer setFrame:NEWFRAME(750-96*2-40-224, 386*2-76-40, 224, 76)];
        btnTransfer.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER];
       // [btnTransfer setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btnTransfer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnTransfer setTitle:@"转账" forState:0];
        btnTransfer.tag = 2;
        [btnTransfer addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnTransfer];
        
    }
    return self;
    
}

- (void)setCoinDetail:(BKCoinDetailModel *)coinDetail
{
    _coinDetail = coinDetail;
    _labelTitle.text = [NSString stringWithFormat:@"我的%@地址",coinDetail.coin];
    _imageViewQCCode.image = [BKUtils getQCWithString:coinDetail.address];
    _labelAddress.text = coinDetail.address;
}

- (void)buttonDown:(UIButton*)btn
{
    if(btn.tag==1)//充值
    {
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string = _coinDetail.address;
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"复制到剪切板" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else //转账
    {
        
    }
}
#pragma UIGestureRecognizer Handles
-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"---单击手势-------");
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
