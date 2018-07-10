//
//  BKBasicViewController.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKBasicViewController : UIViewController

@property (nonatomic, strong) UIView *customNavView;

//背景图片
@property (strong, nonatomic) UIScrollView* scrollViewBg;

/**
 *  自定义NAV上的TitleLabel
 */
@property (nonatomic, strong) UILabel *customNavTitleLabel;

/**
 *  左边button是否显示 default NO
 */
@property (nonatomic, assign) BOOL isLeftButton;
/**
 *  左边button
 */
@property (nonatomic, strong) UIButton *leftButton;
/**
 *  右边button是否显示 default NO
 */
@property (nonatomic, assign) BOOL isRightButton;
/**
 *  右边button
 */
@property (nonatomic, strong) UIButton *rightButton;


/**
 *  制定返回方式  YES模态方式/ NO POP方式
 */
@property (nonatomic, assign) BOOL isModalButton;

/**
 *  自定义导航栏上leftButton的点击事件
 */
- (void)leftBtnAction;
/**
 *  自定义导航栏上RightButton的点击事件
 */
- (void)rightBtnAction;

@end
