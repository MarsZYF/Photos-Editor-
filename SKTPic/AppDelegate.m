//
//  AppDelegate.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/21.
//  Copyright © 2017年 123. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BaseNavViewController.h"
#import "WebViewController.h"
#import "ExcessiveViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)showPreView
{
    if (_preview == nil) {
        _preview = [[ImageAddPreView alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height - 135, self.window.frame.size.width, 135)];
        [_window addSubview:_preview];
    }
    [_preview setAlpha:0];
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [_preview setAlpha:1];
                     } completion:^(BOOL finished) {
                         
                     }];
    [_preview setHidden:NO];
}


- (void)hiddenPreView
{
    [_preview setHidden:YES];
    [_preview setAlpha:0];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController * vc = [[MainViewController alloc] init];
    BaseNavViewController * nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
   
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
