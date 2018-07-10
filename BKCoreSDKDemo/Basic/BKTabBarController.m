//
//  BKTabBarController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKTabBarController.h"
#import "BKUseViewController.h"
#import "BKSetViewController.h"
#import "BKHomeViewController.h"
#import "BKNavigationController.h"


@interface BKTabBarController ()

@end

@implementation BKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addTabbar];
}

-(void)addTabbar
{
    [self setDelegate:self];
    
    
    BKHomeViewController* home = [[BKHomeViewController alloc] init];
    BKNavigationController* homeNav = [[BKNavigationController alloc] initWithRootViewController:home];
    
    BKUseViewController* use = [[BKUseViewController alloc] init];
    BKNavigationController* useNav = [[BKNavigationController alloc] initWithRootViewController:use];
    
    BKSetViewController* set = [[BKSetViewController alloc] init];
    BKNavigationController* setNav = [[BKNavigationController alloc] initWithRootViewController:set];
    

    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeNav,useNav,setNav, nil];
    [self setViewControllers:viewControllers];
    
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //初始化TabBarItem 样式
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      HEXCOLOR_ALPHA(0xFFFFFF, 1),NSForegroundColorAttributeName,
                                      IOS_VERSION_5_FONT_Light(12),NSFontAttributeName, nil] forState:UIControlStateNormal];
        
        switch (i) {
            case 1:{
                [item setImage:[UIImage imageNamed:@"tab_use"]];
                [item setSelectedImage:[UIImage imageNamed:@"tab_use_sec"]];
                [item setTitle:@"应用"];
                
                item.selectedImage= [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                // 选中
                NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
                attrSelected[NSFontAttributeName] =  IOS_VERSION_5_FONT_Light(12);
                attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
                [item setTitleTextAttributes:attrSelected forState:UIControlStateNormal];
                item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
            }
                break;
            case 0:{
                
                
                [item setImage:[UIImage imageNamed:@"tab_home"]];
                [item setSelectedImage:[UIImage imageNamed:@"tab_home_sec"]];
                [item setTitle:@"钱包"];
                
                item.selectedImage= [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                // 选中
                NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
                attrSelected[NSFontAttributeName] =  IOS_VERSION_5_FONT_Light(12);
                attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
                [item setTitleTextAttributes:attrSelected forState:UIControlStateNormal];
                
            }
                break;
            case 2:{
                [item setImage:[UIImage imageNamed:@"tab_set"]];
                [item setSelectedImage:[UIImage imageNamed:@"tab_set_sec"]];
                [item setTitle:@"设置"];
                item.selectedImage= [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                // 选中
                NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
                attrSelected[NSFontAttributeName] =  IOS_VERSION_5_FONT_Light(12);
                attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
                [item setTitleTextAttributes:attrSelected forState:UIControlStateNormal];
                item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
                
                break;
                
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
