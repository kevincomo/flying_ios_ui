//
//  BKBasicViewController.m
//  BKCoreSDKDemo
//
//  Created by wxl on 2018/7/4.
//  Copyright © 2018年 wxl. All rights reserved.
//

#import "BKBasicViewController.h"

@interface BKBasicViewController ()

@end

@implementation BKBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    _customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    if(is5_8inch_retina)
    {
        [_customNavView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    }
    self.customNavView.clipsToBounds = YES;
    _customNavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_customNavView];
    
    
    
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
    if(is5_8inch_retina)
    {
        [_leftButton setFrame:CGRectMake(10, 44, 44, 44)];
    }
    [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER-1];
    [_leftButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.leftButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:0];
    [_customNavView addSubview:_leftButton];
    
    
    _customNavTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-(SCREEN_WIDTH-100))/2, 20, (SCREEN_WIDTH-100), 44)];
    if(is5_8inch_retina)
    {
        [_customNavTitleLabel setFrame:CGRectMake((SCREEN_WIDTH-(SCREEN_WIDTH-100))/2, 44, (SCREEN_WIDTH-100), 44)];
    }
    _customNavTitleLabel.textAlignment = NSTextAlignmentCenter;
    _customNavTitleLabel.textColor = HEXCOLOR_ALPHA(0x000000, 0.87);
    _customNavTitleLabel.font = [UIFont boldSystemFontOfSize:FONTNUMBER+6];
    _customNavTitleLabel.backgroundColor = [UIColor clearColor];
    [_customNavView addSubview:_customNavTitleLabel];
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-54, 20, 44, 44)];
    if(is5_8inch_retina)
    {
        [_rightButton setFrame:CGRectMake(SCREEN_WIDTH-54, 44, 44, 44)];
    }
    
    
    [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:FONTNUMBER-1];;
    
    
    
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.rightButton setTitleColor:RGB(186, 174, 138) forState:UIControlStateNormal];
    
    [_customNavView addSubview:_rightButton];
    
    self.scrollViewBg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if(is5_8inch_retina)
    {
        self.scrollViewBg.frame = CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    self.scrollViewBg.userInteractionEnabled = NO;
    self.scrollViewBg.showsHorizontalScrollIndicator = NO;
    self.scrollViewBg.showsVerticalScrollIndicator = NO;
    self.scrollViewBg.bounces = NO;
    self.scrollViewBg.userInteractionEnabled = YES;
    
    
    [self.view addSubview:self.scrollViewBg];
    
    [self.scrollViewBg setBackgroundColor:[UIColor whiteColor]];
}


- (void)leftBtnAction
{
    if(self.isModalButton) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
