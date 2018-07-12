//
//  BKAllCoinsTableViewCell.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/11.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKAllCoinsTableViewCell.h"

@implementation BKAllCoinsTableViewCell

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
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(28, 15, 750-56, 160)];
        imageViewBg.backgroundColor = [UIColor whiteColor];
        imageViewBg.layer.cornerRadius = 8.0f;
        imageViewBg.layer.masksToBounds = YES;
        imageViewBg.userInteractionEnabled = YES;
        [self.contentView addSubview:imageViewBg];
        
        _imageViewIcon = [[UIImageView alloc] initWithFrame:NEWFRAME(28, 28+10, 160-38*2, 160-38*2)];
        _imageViewIcon.backgroundColor = [UIColor clearColor];
        [imageViewBg addSubview:_imageViewIcon];
        
        _labelCoinCode = [[UILabel alloc] initWithFrame:NEWFRAME(28+160-38*2+20, 28+10, 28*2+58+100, 40)];
        
        _labelCoinCode.backgroundColor = [UIColor clearColor];
        _labelCoinCode.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelCoinCode.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelCoinCode];
        
        
        _labelCoinName = [[UILabel alloc] initWithFrame:NEWFRAME(28+160-38*2+20, 28+10+40, 28*2+58+100, 40)];

        _labelCoinName.backgroundColor = [UIColor clearColor];
        _labelCoinName.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelCoinName.textColor = HEXCOLOR(0x9DA2B1);
        [imageViewBg addSubview:_labelCoinName];
        
        //2. create switch
        self.switchSelect = [[UISwitch alloc] initWithFrame:NEWFRAME(690-100-50, 50, 100, 60)];
        [imageViewBg addSubview:self.switchSelect];
        
        
        // 设置开关状态(默认是 关)
        //    self.mainSwitch.on = YES;
        [self.switchSelect setOn:YES animated:false];  //animated
        
        
        
        //添加事件监听
        [self.switchSelect addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return self;
}

- (void)setCoinDetail:(BKCoinDetailModel *)coinDetail
{
    _coinDetail = coinDetail;
    
    if([coinDetail.required isEqualToString:@"yes"])
    {
        _switchSelect.enabled = NO;
        if([coinDetail.enable isEqualToString:@"off"])
        {
            [self.switchSelect setOn:NO animated:false];
        }
        else
        {
            [self.switchSelect setOn:YES animated:false];
        }
    }
    else
    {
        _switchSelect.enabled = YES;
        if([coinDetail.enable isEqualToString:@"off"])
        {
            [self.switchSelect setOn:NO animated:false];
        }
        else
        {
            [self.switchSelect setOn:YES animated:false];
        }
    }
    _labelCoinName.text = coinDetail.name;
    _labelCoinCode.text = coinDetail.coin;
    [_imageViewIcon sd_setImageWithURL:[NSURL URLWithString:coinDetail.icon] placeholderImage:nil];
}


- (void)switchAction:(UISwitch*)sw
{
    if(sw.on)
    {
        _coinDetail.enable = @"on";
    }
    else
    {
        _coinDetail.enable = @"off";
    }
    _blockSwitch(_coinDetail);
}

@end
