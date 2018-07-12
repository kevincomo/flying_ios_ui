//
//  BKSetView.h
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/12.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKSetView : UIView

@property (copy, nonatomic) void (^blockPassword)(NSString*);

@end
