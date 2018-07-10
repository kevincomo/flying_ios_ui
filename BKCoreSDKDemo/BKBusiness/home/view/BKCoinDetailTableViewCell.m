//
//  BKCoinDetailTableViewCell.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/5.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKCoinDetailTableViewCell.h"

@implementation BKCoinDetailTableViewCell

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
        UIImageView* imageViewBg = [[UIImageView alloc] initWithFrame:NEWFRAME(30, 0, 750-60, 128)];
        imageViewBg.backgroundColor = [UIColor whiteColor];
        imageViewBg.layer.cornerRadius = 8.0f;
        imageViewBg.layer.masksToBounds = YES;
        [self.contentView addSubview:imageViewBg];
        
        //图标
        _imageViewIcon = [[UIImageView alloc] initWithFrame:NEWFRAME(20, 30, 68, 68)];
        _imageViewIcon.backgroundColor = [UIColor clearColor];
        [imageViewBg addSubview:_imageViewIcon];
        
        //行为
        _labelActivityName = [[UILabel alloc] initWithFrame:NEWFRAME(60+40, 25, 500, 40)];
        _labelActivityName.text = [BKUtils DPLocalizedString:@"充值"];
        _labelActivityName.backgroundColor = [UIColor clearColor];
        _labelActivityName.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelActivityName.textColor = HEXCOLOR(0x353F55);
        [imageViewBg addSubview:_labelActivityName];
        
        _labelTime = [[UILabel alloc] initWithFrame:NEWFRAME(60+40, 25+40, 500, 40)];
        _labelTime.text = @"09-09-10";
        _labelTime.backgroundColor = [UIColor clearColor];
        _labelTime.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelTime.textColor = HEXCOLOR(0xBABECB);
        [imageViewBg addSubview:_labelTime];
        
        _labelAmount = [[UILabel alloc] initWithFrame:NEWFRAME(750-60-20-100, 25+20, 100, 40)];
        _labelAmount.text = @"+300";
        _labelAmount.textAlignment = NSTextAlignmentRight;
        _labelAmount.backgroundColor = [UIColor clearColor];
        _labelAmount.font = [UIFont systemFontOfSize:FONTNUMBER-1];
        _labelAmount.textColor = HEXCOLOR(0xBABECB);
        [imageViewBg addSubview:_labelAmount];
    }
    
    return self;
}

- (void)setTradeItemModel:(BKTradeItemModel *)tradeItemModel
{
    _tradeItemModel = tradeItemModel;
    _labelAmount.text = tradeItemModel.amount;
    _labelTime.text = [BKUtils timeStampToTime:tradeItemModel.createdAt];
    if(tradeItemModel.type==1)
    {
        _labelActivityName.text = [BKUtils DPLocalizedString:@"转账"];
        _imageViewIcon.image = [UIImage imageNamed:@"icon_Res"];
    }
    else
    {
        _labelActivityName.text = [BKUtils DPLocalizedString:@"充值"];
        _imageViewIcon.image = [UIImage imageNamed:@"icon_transfer"];
    }
}
@end
