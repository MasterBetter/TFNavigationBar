//
//  CustomListController.m
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "CustomListController.h"

#import "CustomNavBarController.h"
#import "ImageNavController.h"
#import "MillcolorGradController.h"
#import "MoveViewController.h"
#import "TextFiledViewController.h"

@interface CustomListController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CustomListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    self.customNavBar.title =  @"自定义导航栏";
}
 
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = nil;
    switch (indexPath.row) {
        case 0:
            str = @"右边双按钮导航栏";
            break;
        case 1:
            str = @"导航栏显示图片";
            break;
        case 2:
            str = @"普通类型导航栏";
            break;
        case 3:
            str = @"移动导航栏";
            break;
        case 4:
            str = @"textFiled导航栏";
            break;
        default:
            break;
    }
    cell.textLabel.text = str;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CustomNavBarController *customNavBarVC = [CustomNavBarController new];
            [self.navigationController pushViewController:customNavBarVC animated:YES];
        }
            break;
        case 1:
        {
            ImageNavController *imageNavVC = [ImageNavController new];
            [self.navigationController pushViewController:imageNavVC animated:YES];
        }
            break;
        case 2:
        {
            MillcolorGradController *millcolorGradVC = [MillcolorGradController new];
            [self.navigationController pushViewController:millcolorGradVC animated:YES];
        }
            break;
        case 3:
        {
            MoveViewController *moveVC = [MoveViewController new];
            [self.navigationController pushViewController:moveVC animated:YES];
        }
            break;
        case 4:
        {
            TextFiledViewController *moveVC = [TextFiledViewController new];
            [self.navigationController pushViewController:moveVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGFloat top = [TFCustomNavigationBar navBarHeight];
        CGRect frame = CGRectMake(0, top, self.view.frame.size.width, self.view.frame.size.height-top-49);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
