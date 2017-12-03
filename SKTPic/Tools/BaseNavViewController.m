//
//  BaseNavViewController.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/22.
//  Copyright © 2017年 123. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navback"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(clickBackBarButton:)];
//        backBarButtonItem.tintColor= [UIColor whiteColor];
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        [viewController setHidesBottomBarWhenPushed:animated];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)clickBackBarButton:(UIBarButtonItem *)item
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([vc isKindOfClass:[UITabBarController class]])
    {
        [self popViewControllerAnimated:YES];
    }
    else
    {
        [self popToRootViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
