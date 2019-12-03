//
//  TFCustomNavigationBar.h
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickLeftButton1)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);
@property (nonatomic, copy) void(^onClickRightButton1)(void);



@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;
@property (nonatomic, strong) UIView   *centerView;

+ (instancetype)CustomNavigationBar;

- (void)tf_setBottomLineHidden:(BOOL)hidden;
- (void)tf_setBackgroundAlpha:(CGFloat)alpha;
- (void)tf_setTintColor:(UIColor *)color;

// 默认返回事件
- (void)tf_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)tf_setLeftButtonWithImage:(UIImage *)image;
- (void)tf_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

 
 
- (void)tf_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)tf_setRightButtonWithImage:(UIImage *)image;
- (void)tf_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



- (void)tf_setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)tf_setRightButton1WithImage:(UIImage *)image;
- (void)tf_setRightButton1WithTitle:(NSString *)title titleColor:(UIColor *)titleColor;


+ (BOOL)isIphoneX;

+ (CGFloat)navBarHeight;

 
/** 设置导航栏在垂直方向上平移多少距离 */
- (void)tf_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)tf_getTranslationY;
@end













