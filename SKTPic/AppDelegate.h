//
//  AppDelegate.h
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/21.
//  Copyright © 2017年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageAddPreView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ImageAddPreView   *preview;

- (void)showPreView;
- (void)hiddenPreView;
@end

