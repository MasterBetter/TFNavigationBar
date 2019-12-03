//
//  AppDelegate.m
//  TFNavigationBar
//
//  Created by 吴腾飞 on 2019/12/3.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomListController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    CustomListController *rootViewController = [[CustomListController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}
 
 

@end
