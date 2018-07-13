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

@property (strong, nonatomic) BKTextField* textFieldAccount;

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
        [textField addTextFieldToSuperView:self TextFieldFrame:NEWFRAME(30, 65, 690, 104) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"输入密码（6位数字）"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor whiteColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"" RightViewText:@""];
        
        _textFieldPassword = textField;
        
        UIButton* btnSetPassword = [UIButton buttonWithType:0];
        [btnSetPassword setFrame:NEWFRAME(30, 200, 690, 100)];
        [btnSetPassword setTitle:[BKUtils DPLocalizedString:@"设置密码"] forState:0];
        btnSetPassword.tag = 1;
        [btnSetPassword addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnSetPassword.backgroundColor = [UIColor blackColor];
        [self addSubview:btnSetPassword];
        
        UIButton* btnLogout = [UIButton buttonWithType:0];
        btnLogout.tag = 2;
        [btnLogout setFrame:NEWFRAME(30, 330, 690, 100)];
        [btnLogout setTitle:[BKUtils DPLocalizedString:@"退出账号"] forState:0];
        [btnLogout addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnLogout.backgroundColor = [UIColor blackColor];
        [self addSubview:btnLogout];
        
        
        BKTextField* textFieldLogin = [BKTextField new];
        
        //完全自定义
        [textFieldLogin addTextFieldToSuperView:self TextFieldFrame:NEWFRAME(30, 460, 690, 104) TextFieldPlaceholderText:[BKUtils DPLocalizedString:@"输入app自己的id"] TextFieldPlacegolderColor:[UIColor grayColor] TextFieldPlacegolderFontSize:14 TextFieldCornerRadius:8.0f textFieldBackgroundColor:[UIColor whiteColor] TextFieldRightViewRightMargin:2 RightViewImageName:@"" RightViewText:@""];
        
        textFieldLogin.textField.keyboardType = UIKeyboardTypeDefault;
        _textFieldAccount = textFieldLogin;
        
        UIButton* btnLogin = [UIButton buttonWithType:0];
        [btnLogin setFrame:NEWFRAME(30, 590, 690, 100)];
        [btnLogin setTitle:[BKUtils DPLocalizedString:@"登入账号"] forState:0];
        btnLogin.tag = 3;
        [btnLogin addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        btnLogin.backgroundColor = [UIColor blackColor];
        [self addSubview:btnLogin];
        
        
        
    }
    return self;
}

- (void)buttonDown:(UIButton*)btn
{
    switch(btn.tag)
    {
        case 1:
        {
            _blockPassword(_textFieldPassword.textField.text);
        }
            break;
        case 2:
        {
            _blockLogout();
        }
            break;
        case 3:
        {
            _blockLogIn(_textFieldAccount.textField.text);
        }
            break;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
