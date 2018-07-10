//
//  BKTextField.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/7.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKTextField.h"

#define RIGHTVIEW_TEXT_TAG  1000

@implementation BKTextField

-(instancetype)init{
    if (self = [super init]) {
        
        UITextField*textField = [UITextField new];
        self.textField = textField;
        [self.textField addTarget:self action:@selector(editEventChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

-(void)editEventChange:(UITextField*)text{
    if (self.clickTextFieldBlock) {
        self.clickTextFieldBlock(text.text);
    }
}

-(void)addTextFieldToSuperView:(UIView*)superView
                TextFieldFrame:(CGRect)textFieldFrame
      TextFieldPlaceholderText:(NSString*)text
     TextFieldPlacegolderColor:(UIColor*)textFieldPlaceholderColor
  TextFieldPlacegolderFontSize:(CGFloat)textFieldPlacegolderFontSize{
    
    
    [superView addSubview:self.textField];
    
    //frame
    self.textField.frame = textFieldFrame;
    self.textField.placeholder = text;
    
    //placeHolder
    [self.textField setValue:textFieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont systemFontOfSize:textFieldPlacegolderFontSize]forKeyPath:@"_placeholderLabel.font"];
    
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

-(void)addTextFieldToSuperView:(UIView*)superView TextFieldFrame:(CGRect)textFieldFrame
      TextFieldPlaceholderText:(NSString*)text TextFieldPlacegolderColor:(UIColor*)textFieldPlaceholderColor TextFieldPlacegolderFontSize:(CGFloat)textFieldPlacegolderFontSize TextFieldCornerRadius:(CGFloat)cornerRadius textFieldBackgroundColor:(UIColor*)textFieldBackgroundColor TextFieldLeftViewLeftMargin:(CGFloat)textFieldLeftViewLeftMargin LeftViewImageName:(NSString*)leftViewImageName{
    
    [superView addSubview:self.textField];
    
    //frame
    self.textField.frame = textFieldFrame;
    self.textField.placeholder = text;
    
    //placeHolder
    [self.textField setValue:textFieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont systemFontOfSize:textFieldPlacegolderFontSize]forKeyPath:@"_placeholderLabel.font"];
    
    //cornerRadius
    self.textField.layer.cornerRadius = cornerRadius;
    
    //color
    self.textField.backgroundColor = textFieldBackgroundColor;
    
    //leftView
    if (leftViewImageName && textFieldLeftViewLeftMargin != 0) {
        UIImage *im = [UIImage imageNamed:leftViewImageName];
        UIImageView *iv = [[UIImageView alloc] initWithImage:im];
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(textFieldLeftViewLeftMargin, 0, 45, 50)];
        iv.center = self.leftView.center;
        [self.leftView addSubview:iv];
        self.textField.leftView = self.leftView;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

/**
 完全自定义textField
 @param superView 要添加到的视图
 @param textFieldFrame frame
 @param textFieldRightViewRightMargin rightView左间距
 @param rightViewImageName rightView图片
 @param rightViewText rightView文案
 */
-(void)addTextFieldToSuperView:(UIView*)superView
                TextFieldFrame:(CGRect)textFieldFrame
      TextFieldPlaceholderText:(NSString*)text
     TextFieldPlacegolderColor:(UIColor*)textFieldPlaceholderColor
  TextFieldPlacegolderFontSize:(CGFloat)textFieldPlacegolderFontSize
         TextFieldCornerRadius:(CGFloat)cornerRadius
      textFieldBackgroundColor:(UIColor*)textFieldBackgroundColor
 TextFieldRightViewRightMargin:(CGFloat)textFieldRightViewRightMargin
            RightViewImageName:(NSString*)rightViewImageName
                 RightViewText:(NSString*)rightViewText
{
    [superView addSubview:self.textField];
    
    //frame
    self.textField.frame = textFieldFrame;
    self.textField.placeholder = text;
    
    //placeHolder
    [self.textField setValue:textFieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont systemFontOfSize:textFieldPlacegolderFontSize]forKeyPath:@"_placeholderLabel.font"];
    
    //cornerRadius
    self.textField.layer.cornerRadius = cornerRadius;
    
    //color
    self.textField.backgroundColor = textFieldBackgroundColor;
    
    //leftView
    if (rightViewImageName && textFieldRightViewRightMargin != 0) {
        UIImage *im = [UIImage imageNamed:rightViewImageName];
        UIImageView *iv = [[UIImageView alloc] initWithImage:im];
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(textFieldRightViewRightMargin, 0, 30, 50)];
        iv.center = self.rightView.center;
        
        UILabel* labelText = [[UILabel alloc] initWithFrame:CGRectMake(textFieldRightViewRightMargin, 0, 30, 50)];
        labelText.tag = RIGHTVIEW_TEXT_TAG;
        labelText.text = rightViewText;
        labelText.font = [UIFont systemFontOfSize:FONTNUMBER-4];
        labelText.backgroundColor = [UIColor clearColor];
        
        [self.rightView addSubview:labelText];
        [self.rightView addSubview:iv];
        self.textField.rightView = self.rightView;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(textFieldRightViewRightMargin, 0, 10, 50)];
        iv.center = self.leftView.center;
        self.textField.leftView = self.leftView;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        
        
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        tapRecognize.numberOfTapsRequired = 1;
        tapRecognize.delegate = self;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [tapRecognize cancelsTouchesInView];
        
        [self.rightView addGestureRecognizer:tapRecognize];
        
    }
    
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)setRightViewText:(NSString *)rightViewText
{
    _rightViewText = rightViewText;
    UILabel* la = [self.rightView viewWithTag:RIGHTVIEW_TEXT_TAG];
    la.text = rightViewText;
}

- (void)handleTap
{
    _blockClickRight();
}
-(void)dealloc{
    NSLog(@"YMSTextField-dealloc");
}
@end
