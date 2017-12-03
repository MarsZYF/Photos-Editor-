//
//  ExcessiveViewController.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/29.
//  Copyright © 2017年 123. All rights reserved.
//

#import "ExcessiveViewController.h"

@interface ExcessiveViewController ()

@end

@implementation ExcessiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    image.image=[UIImage imageNamed:@"LaunchImage"];
    [self.view addSubview:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
