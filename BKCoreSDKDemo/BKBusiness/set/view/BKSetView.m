//
//  BKSetView.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/12.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKSetView.h"
#import "BKTextField.h"

@interface BKSetView ()

@property (strong, nonatomic) BKTextField* textFieldPassword;
@end

@implementation BKSetView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = HEXCOLOR(0xF4F4F4);
        
        BKTextField* textField = [BKTextField new];
        
        //完全自定义
        [textField addTextFieldToSuperView:self TextFieldFrame:NEWFRAME(30, 65, 690, 104) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"输入密码"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor whiteColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"" RightViewText:@""];
        
        _textFieldPassword = textField;
        
        UIButton* btnSetPassword = [UIButton buttonWithType:0];
        [btnSetPassword setFrame:NEWFRAME(30, 700, 690, 100)];
        [btnSetPassword setTitle:[BKUtils DPLocalizedString:@"设置密码"] forState:0];
        [btnSetPassword addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnSetPassword.backgroundColor = [UIColor blackColor];
        [self addSubview:btnSetPassword];
        
    }
    return self;
}

- (void)buttonDown:(UIButton*)btn
{
    _blockPassword(_textFieldPassword.textField.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
