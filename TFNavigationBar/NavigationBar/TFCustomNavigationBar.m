//
//  TFCustomNavigationBar.m
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "TFCustomNavigationBar.h"
#import "sys/utsname.h"

#define kWRDefaultTitleSize 18
#define kWRDefaultTitleColor [UIColor blackColor]
#define kWRDefaultBackgroundColor [UIColor whiteColor]
#define kWRScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation UIViewController (WRRoute)

- (void)tf_toLastViewController{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController*)tf_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self tf_currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)tf_currentViewControllerFrom:(UIViewController*)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self tf_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self tf_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self tf_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end

@interface TFCustomNavigationBar ()
@property (nonatomic, strong) UILabel     *titleLable;
@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIButton    *rightButton1;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView      *titleBarView;
@end

@implementation TFCustomNavigationBar

+ (instancetype)CustomNavigationBar {
    TFCustomNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, kWRScreenWidth, [TFCustomNavigationBar navBarHeight])];
    return navigationBar;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
     
    
    [self addSubview:self.titleLable];
    
    [self addSubview:self.rightButton1];
    [self addSubview:self.rightButton];
    
    [self addSubview:self.bottomLine];
    [self addSubview:self.titleBarView];
    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = kWRDefaultBackgroundColor;
}
 
-(void)updateFrame {
    NSInteger top = ([TFCustomNavigationBar isIphoneX]) ? 44 : 20;
    NSInteger margin = 0;
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 44;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = 220;
    
    CGFloat W = kWRScreenWidth-120;
    
    self.backgroundView.frame = self.bounds;
    
    self.backgroundImageView.frame = self.bounds;
    
    self.leftButton.frame = CGRectMake(margin, top, buttonWidth, buttonHeight);
    
    self.rightButton1.frame = CGRectMake(kWRScreenWidth - buttonWidth*2 - margin, top, buttonWidth, buttonHeight);
    
    self.rightButton.frame = CGRectMake(kWRScreenWidth - buttonWidth - margin, top, buttonWidth, buttonHeight);
    
    self.titleLable.frame = CGRectMake((kWRScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    
    self.titleBarView.frame = CGRectMake((kWRScreenWidth - W)/2, top, W, titleLabelHeight);
    
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), kWRScreenWidth, 0.5);
}

#pragma mark - 导航栏左右按钮事件
-(void)clickBack {
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    } else {
        UIViewController *currentVC = [UIViewController tf_currentViewController];
        [currentVC tf_toLastViewController];
    }
}
-(void)clickBack1 {
    if (self.onClickLeftButton1) {
        self.onClickLeftButton1();
    }
}
-(void)clickRight {
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}
-(void)clickRight1 {
    if (self.onClickRightButton1) {
        self.onClickRightButton1();
    }
}
- (void)tf_setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)tf_setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)tf_setTintColor:(UIColor *)color {
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton1 setTitleColor:color forState:UIControlStateNormal];
    [self.titleLable setTextColor:color];
}

#pragma mark - 左右按钮
//左边
- (void)tf_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.leftButton.hidden = NO;
    [self.leftButton setImage:normal forState:UIControlStateNormal];
    [self.leftButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)tf_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)tf_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self tf_setLeftButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)tf_setLeftButtonWithImage:(UIImage *)image {
    [self tf_setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)tf_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}


//右边
- (void)tf_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton.hidden = NO;
    [self.rightButton setImage:normal forState:UIControlStateNormal];
    [self.rightButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)tf_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)tf_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self tf_setRightButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)tf_setRightButtonWithImage:(UIImage *)image {
    [self tf_setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)tf_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

//右边1
- (void)tf_setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton1.hidden = NO;
    [self.rightButton1 setImage:normal forState:UIControlStateNormal];
    [self.rightButton1 setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton1 setTitle:title forState:UIControlStateNormal];
    [self.rightButton1 setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)tf_setRightButton1WithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setRightButton1WithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)tf_setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self tf_setRightButton1WithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)tf_setRightButton1WithImage:(UIImage *)image {
    [self tf_setRightButton1WithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)tf_setRightButton1WithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self tf_setRightButton1WithNormal:nil highlighted:nil title:title titleColor:titleColor];
}


#pragma mark - setter
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleBarView.hidden = YES;
    self.titleLable.hidden = NO;
    self.titleLable.text = _title;
}
- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLable.textColor = _titleLabelColor;
}
- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = _titleLabelFont;
}
-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = _barBackgroundColor;
}
- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = _barBackgroundImage;
}
- (void)setCenterView:(UIView *)centerView{
    
    self.titleLable.hidden = YES;
    self.titleBarView.hidden = NO;
    [self.titleBarView addSubview:centerView];
    
}
#pragma mark - getter
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.hidden = YES;
    }
    return _leftButton;
}
-(UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.hidden = YES;
    }
    return _rightButton;
}
-(UIButton *)rightButton1 {
    if (!_rightButton1) {
        _rightButton1 = [[UIButton alloc] init];
        [_rightButton1 addTarget:self action:@selector(clickRight1) forControlEvents:UIControlEventTouchUpInside];
        _rightButton1.imageView.contentMode = UIViewContentModeCenter;
        _rightButton1.hidden = YES;
    }
    return _rightButton1;
}
-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = kWRDefaultTitleColor;
        _titleLable.font = [UIFont systemFontOfSize:kWRDefaultTitleSize];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.hidden = YES;
    }
    return _titleLable;
}
- (UIView *)titleBarView {
    if (!_titleBarView) {
        _titleBarView = [[UIView alloc] init];
        _titleBarView.backgroundColor = [UIColor clearColor];
        _titleBarView.hidden = YES;
    }
    return _titleBarView;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    }
    return _bottomLine;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

+ (BOOL)isIphoneX {
    BOOL isIPhoneX = [UIScreen mainScreen].bounds.size.height >=812.0;
    return isIPhoneX;
}

+ (CGFloat)navBarHeight{
    
    CGFloat top = [self isIphoneX] ? 88 : 64;
    
    return top;
}

// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)tf_getTranslationY {
    return self.transform.ty;
}

// 设置导航栏在垂直方向上平移多少距离   CGAffineTransformMakeTranslation  平移
- (void)tf_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

 

@end


















