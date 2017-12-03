//
//  WebViewController.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/29.
//  Copyright © 2017年 123. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"CPimagebg"];
    [self.view addSubview:imageView];
    UIButton * cpBtn = [[UIButton alloc] init];
    [cpBtn setBackgroundImage:[UIImage imageNamed:@"CPBtnImage"] forState:UIControlStateNormal];
    [cpBtn addTarget:self action:@selector(goSafari:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cpBtn];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    [cpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(267, 290));
    }];
}
-(void)goSafari:(UIButton*)sender
{
    if (self.weburl)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.weburl]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
