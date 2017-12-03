//
//  PhotoEditorViewController.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/21.
//  Copyright © 2017年 123. All rights reserved.
//

#import "PhotoEditorViewController.h"
#import "PJEditImageBackImageView.h"
@interface PhotoEditorViewController ()
{
    CGSize imageSize ;
    CGFloat width ;
}
@property(nonatomic,strong)UIImage * seletedImage ;
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UIImageView * contentImage ;
@property(nonatomic,strong)UISlider * MosaicSlider;
@property(nonatomic,strong)UIImageView * mosaicImge;
@property (nonatomic, strong) PJEditImageBackImageView *touchView;
@property (nonatomic, assign) BOOL isBlur;

@end

@implementation PhotoEditorViewController

-(instancetype)initWithImage:(UIImage*)image
{
    self= [super init];
    if (self) {
        self.seletedImage = image;
       imageSize= [self getScaleImageSize];
    }
    return self;
}
-(CGSize)getScaleImageSize {
    float heightScale =kScreenHeight/_seletedImage.size.height/1.0;
    float widthScale = kScreenWidth/_seletedImage.size.width/1.0;
    float scale = MIN(heightScale, widthScale);
    float h = _seletedImage.size.height*scale;
    float w = _seletedImage.size.width*scale;
    return CGSizeMake(w, h);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.touchView = [PJEditImageBackImageView initWithImage:self.seletedImage frame:CGRectMake(0, 0, imageSize.width, imageSize.height) lineWidth:10 lineColor:[UIColor clearColor]];
    self.touchView.centerY=self.view.centerY;
    self.touchView.centerX= self.view.centerX;
    self.touchView.contentMode =UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.touchView];
    self.touchView.backgroundColor = [UIColor blackColor];

    
    UIView * tools = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight -30, kScreenWidth, 30)];
    tools.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tools];
    
    UIImage * mosimage =[UIImage imageNamed:@"masoic"];
    UIButton * mosBtn1 = [[UIButton alloc] init];
    mosBtn1.tag =1001;
    [mosBtn1 setBackgroundImage:mosimage forState:UIControlStateNormal];
    [mosBtn1 addTarget:self action:@selector(Mosaic:) forControlEvents:UIControlEventTouchUpInside];
    [tools addSubview:mosBtn1];
    
    UIButton * mosBtn2 = [[UIButton alloc] init];
    mosBtn2.tag =1002;
    [mosBtn2 setBackgroundImage:mosimage forState:UIControlStateNormal];
    [mosBtn2 addTarget:self action:@selector(Mosaic:) forControlEvents:UIControlEventTouchUpInside];
    [tools addSubview:mosBtn2];

    UIButton * mosBtn3 = [[UIButton alloc] init];
    mosBtn3.tag =1003;
    [mosBtn3 setBackgroundImage:mosimage forState:UIControlStateNormal];
    [mosBtn3 addTarget:self action:@selector(Mosaic:) forControlEvents:UIControlEventTouchUpInside];
    [tools addSubview:mosBtn3];
    
    UIButton * mosBtn4 = [[UIButton alloc] init];
    mosBtn4.tag =1004;
    [mosBtn4 setBackgroundImage:mosimage forState:UIControlStateNormal];
    [mosBtn4 addTarget:self action:@selector(Mosaic:) forControlEvents:UIControlEventTouchUpInside];
    [tools addSubview:mosBtn4];
    
    UIButton * backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"revocation"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [tools addSubview:backBtn];

    UIButton * cannelBtn  = [[UIButton alloc] init];
    [cannelBtn setBackgroundImage:[UIImage imageNamed:@"story_maker_close"] forState:UIControlStateNormal];
    [cannelBtn addTarget:self action:@selector(popto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cannelBtn];
    
    UIButton * save   = [[UIButton alloc] init];
    [save setBackgroundImage:[UIImage imageNamed:@"square-download"] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:save];
//    
//    [mosBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(tools.mas_left).mas_offset(120);
//        make.bottom.mas_equalTo(tools).mas_offset(-8);
//        make.height.mas_equalTo(@8);
//        make.width.equalTo(@8);
//    }];
//    [mosBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(mosBtn1.mas_right).mas_offset(30);
//        make.bottom.mas_equalTo(tools).mas_offset(-8);
//        make.height.mas_equalTo(@12);
//        make.width.equalTo(@12);
//    }];
//    [mosBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(tools).mas_offset(-8);
//        make.left.mas_equalTo(mosBtn2.mas_right).mas_offset(30);
//        make.height.mas_equalTo(@16);
//        make.width.equalTo(@16);
//    }];
//
//    [mosBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(mosBtn3.mas_right).mas_offset(30);
//        make.bottom.mas_equalTo(tools).mas_offset(-8);
//        make.height.mas_equalTo(20);
//        make.width.equalTo(@20);
//    }];
    [@[mosBtn1,mosBtn2,mosBtn3,mosBtn4] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:40 leadSpacing:80 tailSpacing:80];
    [@[mosBtn1,mosBtn2,mosBtn3,mosBtn4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (tools.mas_centerY);
    }];
    [mosBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    [mosBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    [mosBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [mosBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(tools).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(tools);
    }];
    [cannelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        if (iPhoneX)
        {
        make.top.mas_equalTo (self.view.mas_top).offset(50);
        }
        else
        {
            make.top.mas_equalTo (self.view.mas_top).offset(20);
        }
            
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        if (iPhoneX)
        {
            make.top.mas_equalTo (self.view.mas_top).offset(50);
        }
        else
        {
            make.top.mas_equalTo (self.view.mas_top).offset(20);
        }
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    
}
-(void)popto:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save:(UIButton*)sender
{
    UIGraphicsBeginImageContextWithOptions(self.touchView.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.touchView.layer renderInContext:ctx];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(newImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
    [[LoadingViewManager sharedInstance] showHUDWithText:@"save success" inView:self.view duration:0.5f];

}
-(void)back:(UIButton*)sender
{
    [self.touchView revokeScreen];
}

-(void)Mosaic:(UIButton*)sender
{
    sender.selected=YES;
    _isBlur =YES;
    self.touchView.isBlur = _isBlur;
    switch (sender.tag) {
        case 1001:
            width = 5;
            break;
        case 1002:
            width = 10;
            break;
        case 1003:
            width = 20;
            break;
        case 1004:
            width = 30;
            break;
        default:
            break;
    }
    self.touchView.moswidth=width;
    
}
-(UIView*)bgView
{
    if (!_bgView) {
        _bgView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [UIColor blackColor];
    }
    return _bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
