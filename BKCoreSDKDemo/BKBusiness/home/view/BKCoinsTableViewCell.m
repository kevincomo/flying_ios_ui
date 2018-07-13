//
//  BKCoinsTableViewCell.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinsTableViewCell.h"

@implementation BKCoinsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = HEXCOLOR(0xF3F4F6);
        //400
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(28, 0, 750-56, 160)];
        imageViewBg.backgroundColor = [UIColor whiteColor];
        imageViewBg.layer.cornerRadius = 8.0f;
        imageViewBg.layer.masksToBounds = YES;
        imageViewBg.userInteractionEnabled = YES;
        [self.contentView addSubview:imageViewBg];
        
        _imageViewIcon = [[UIImageView alloc] initWithFrame:NEWFRAME(28, 28+10, 58, 58)];
        _imageViewIcon.backgroundColor = [UIColor clearColor];
        [imageViewBg addSubview:_imageViewIcon];
        
        _labelName = [[UILabel alloc] initWithFrame:NEWFRAME(0, 28+60+10, 28*2+58, 40)];
        _labelName.textAlignment = NSTextAlignmentCenter;
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelName.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelName];
        
        _labelHoldCoin = [[UILabel alloc] initWithFrame:NEWFRAME(87*2, 28+10, 200, 40)];
       // _labelHoldCoin.textAlignment = NSTextAlignmentCenter;
        _labelHoldCoin.backgroundColor = [UIColor clearColor];
        _labelHoldCoin.font = [UIFont boldSystemFontOfSize:FONTNUMBER];
        _labelHoldCoin.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelHoldCoin];
        
        
        _labelHoldCurry = [[UILabel alloc] initWithFrame:NEWFRAME(87*2, 28+60, 200, 40)];

    
        _labelHoldCurry.backgroundColor = [UIColor clearColor];
        _labelHoldCurry.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelHoldCurry.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelHoldCurry];
        
        _labelTicker = [[UILabel alloc] initWithFrame:NEWFRAME(200*2-80, 28+10, 160, 40)];
        _labelTicker.textAlignment = NSTextAlignmentRight;
        _labelTicker.backgroundColor = [UIColor clearColor];
        _labelTicker.font = [UIFont boldSystemFontOfSize:FONTNUMBER];
        _labelTicker.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelTicker];
        
        
        _labelMargin = [[UILabel alloc] initWithFrame:NEWFRAME(200*2-80, 28+60, 160, 40)];
        _labelMargin.textAlignment = NSTextAlignmentRight;
        _labelMargin.backgroundColor = [UIColor clearColor];
        _labelMargin.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelMargin.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelMargin];
        
        UIButton* btn = [UIButton buttonWithType:0];
        [btn setImage:[UIImage imageNamed:@"QCCode"] forState:0];
        btn.frame = NEWFRAME(310*2, (160-36)/2, 36, 36);
        [btn addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btn];
    }
    
    return self;
}

- (void)setCoinDetail:(BKCoinDetailModel *)coinDetail
{
    _coinDetail = coinDetail;
    
    NSNumber* number = [[NSNumber alloc] initWithInt:0];
    if([coinDetail.margin hasPrefix:@"-"])
    {
        _labelMargin.textColor = [UIColor greenColor];
    }
    else
    {
        _labelMargin.textColor = [UIColor redColor];
    }
    _labelMargin.text = [NSString stringWithFormat:@"%@%%",coinDetail.margin];
    
    _labelName.text = coinDetail.coin;
    _labelTicker.text = coinDetail.ticker;
    _labelHoldCoin.text = coinDetail.amount;
    _labelHoldCurry.text = coinDetail.price;
    [_imageViewIcon sd_setImageWithURL:[NSURL URLWithString:coinDetail.icon] placeholderImage:nil];
}
- (void)buttonDown:(UIButton*)btn
{
    _blockQCCode(_coinDetail);
}
@end
