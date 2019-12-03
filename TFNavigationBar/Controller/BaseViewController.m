//
//  BaseViewController.m
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "BaseViewController.h"
 
@interface BaseViewController ()



@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];

    // 设置自定义导航栏背景图片
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [TFCustomNavigationBar navBarHeight]);
    UIColor *topleftColor = [UIColor colorWithRed:148/255.0f green:127/255.0f blue:202/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:(141/255.0) green:(137/255.0) blue:(244/255.0) alpha:(1)];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:1 imgSize:size];
     
    self.customNavBar.barBackgroundColor = [UIColor colorWithPatternImage:bgImg];

    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];

    if (self.navigationController.childViewControllers.count != 1) { 
        [self.customNavBar tf_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    }
}

- (TFCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [TFCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

@end
