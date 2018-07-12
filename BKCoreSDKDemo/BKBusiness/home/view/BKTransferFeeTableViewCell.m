//
//  BKTransferFeeTableViewCell.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/7.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKTransferFeeTableViewCell.h"

@implementation BKTransferFeeTableViewCell

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
        
        _imageViewIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transfer_sec"]];
        _imageViewIcon.userInteractionEnabled = YES;
        _imageViewIcon.layer.shadowRadius = YES;
        _imageViewIcon.layer.masksToBounds = YES;
        [_imageViewIcon setFrame:NEWFRAME(30, 30, 38, 38)];
        _imageViewIcon.backgroundColor = HEXCOLOR(0xF4F4F4);
        [self.contentView addSubview:_imageViewIcon];
        
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        tapRecognize.numberOfTapsRequired = 1;
        tapRecognize.delegate = self;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [tapRecognize cancelsTouchesInView];
        
        [_imageViewIcon addGestureRecognizer:tapRecognize];
        
        
        
        _labelText = [[UILabel alloc] initWithFrame:NEWFRAME(72, 30, 500, 38)];
        _labelText.text = @"100BKB";
        _labelText.backgroundColor = [UIColor clearColor];
        _labelText.font = [UIFont systemFontOfSize:FONTNUMBER];
        [self.contentView addSubview:_labelText];
        
        
    }
    return self;
}

- (void)handleTap
{
    _blockClickSec();
}

- (void)setCoinFeeModel:(BKCoinFeeSecModel *)coinFeeModel
{
    _coinFeeModel = coinFeeModel;
    _labelText.text = [NSString stringWithFormat:@"%@%@",coinFeeModel.fee ,coinFeeModel.coin];
    
    
    if(coinFeeModel.boolSec)
    {
        _imageViewIcon.image = [UIImage imageNamed:@"transfer_sec"];
    }
    else
    {
        _imageViewIcon.image = [UIImage imageNamed:@""];
    }
}

@end
