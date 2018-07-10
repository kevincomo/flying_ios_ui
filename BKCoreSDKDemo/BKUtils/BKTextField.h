//
//  BKTextField.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/7.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BKTextField : NSObject

@property(nonatomic,weak)UITextField*textField;

@property(nonatomic,copy)NSString*text;
/**
 placeholder颜色
 */
@property(nonatomic,strong)UIColor*textFieldPlaceholderColor;

/**
 字体大小
 */
@property(nonatomic,assign)CGFloat textFieldFontSize;

/**
 圆角
 */
@property(nonatomic,assign)CGFloat cornerRadius;

/**
 textField的背景颜色
 */
@property(nonatomic,strong)UIColor*textFieldBackgroundColor;

/**
 textField左视图
 */
@property(nonatomic,strong)UIView*leftView;

/**
 左视图的图片名称
 */
@property(nonatomic,copy)NSString*leftViewImageName;

/**
 leftView 的左间距
 */
@property(nonatomic,assign)CGFloat textFieldLeftViewLeftMargin;


/**
 textField右视图
 */
@property(nonatomic,strong)UIView* rightView;

/**
 左视图的图片名称
 */
@property(nonatomic,copy)NSString* rightViewImageName;

/**
 leftView 的左间距
 */
@property(nonatomic,assign)CGFloat textFieldRightViewRightMargin;

/**
 右视图文案
 */
@property (copy, nonatomic) NSString* rightViewText;
/**
 监听输入文字
 */
@property(nonatomic,copy)void(^clickTextFieldBlock)(NSString*);

/**
 点击右视图的回调
 */
@property (copy, nonatomic) void(^blockClickRight)(void);

/**
 简单自定义
 */
-(void)addTextFieldToSuperView:(UIView*)superView
                TextFieldFrame:(CGRect)textFieldFrame
      TextFieldPlaceholderText:(NSString*)text
     TextFieldPlacegolderColor:(UIColor*)textFieldPlaceholderColor
  TextFieldPlacegolderFontSize:(CGFloat)textFieldPlacegolderFontSize;


/**
 完全自定义textField
 @param superView 要添加到的视图
 @param textFieldFrame frame
 @param textFieldLeftViewLeftMargin leftView左间距
 @param leftViewImageName leftView图片
 */
-(void)addTextFieldToSuperView:(UIView*)superView
                TextFieldFrame:(CGRect)textFieldFrame
      TextFieldPlaceholderText:(NSString*)text
     TextFieldPlacegolderColor:(UIColor*)textFieldPlaceholderColor
  TextFieldPlacegolderFontSize:(CGFloat)textFieldPlacegolderFontSize
         TextFieldCornerRadius:(CGFloat)cornerRadius
      textFieldBackgroundColor:(UIColor*)textFieldBackgroundColor
   TextFieldLeftViewLeftMargin:(CGFloat)textFieldLeftViewLeftMargin
             LeftViewImageName:(NSString*)leftViewImageName;


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
                 RightViewText:(NSString*)rightViewText;

@end
