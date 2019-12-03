//
//  MoveViewController.m
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "MoveViewController.h"

// offsetY > -64 的时候导航栏开始偏移
#define NAVBAR_TRANSLATION_POINT 0
#define NavBarHeight 44

@interface MoveViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation MoveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customNavBar.title = @"浮动效果";
     self.view.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:self.tableView];
       [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];

    self.tableView.tableHeaderView = self.imgView;
       if (@available(iOS 11.0, *)) {
           self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       }
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self setNavigationBarTransformProgress:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_TRANSLATION_POINT)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self setNavigationBarTransformProgress:1];
            [self.customNavBar tf_setBackgroundAlpha:.5];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self setNavigationBarTransformProgress:0];
            [self.customNavBar tf_setBackgroundAlpha:1];
        }];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.customNavBar tf_setTranslationY:(-44 * progress)];  
    CGFloat top = [TFCustomNavigationBar navBarHeight];
    _tableView.frame =CGRectMake(0, top-44 * progress, self.view.frame.size.width, self.view.frame.size.height-top);
    
}




#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    vc.title = str;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGFloat top = [TFCustomNavigationBar navBarHeight];
        CGRect frame = CGRectMake(0, top, self.view.frame.size.width, self.view.frame.size.height-top);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        //_tableView.contentInset = UIEdgeInsetsMake(-64+top, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image2"]];
    }
    return _imgView;
}

@end
