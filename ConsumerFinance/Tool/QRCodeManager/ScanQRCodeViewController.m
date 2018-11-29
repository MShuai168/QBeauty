//
//  ScanQRCodeViewController.m
//  QRCodeDemo
//
//  Created by 侯荡荡 on 16/8/26.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "AlbumManager.h"
#import "QRCodeManager.h"

@interface ScanQRCodeViewController ()<UIAlertViewDelegate>

@end

static NSString *scanResults = nil;

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initVirtualNavigationBar];
    [self scanQRCode];
    [self checkAlbumPermission];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[QRCodeManager manager] startScanQRCodeAnimation];
}

- (void)initVirtualNavigationBar {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width - 100)/2, 20, 100, 44)];
    [label setText:@"扫描二维码"];
    [label setFont:[UIFont systemFontOfSize:16.f]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, 20, 60, 44)];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:self action:@selector(closeScanQRCode) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(self.view.frame.size.width - 15 - 60, 20, 60, 44)];
    [button setTitle:@"相册" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button addTarget:self action:@selector(discernQRCode) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
}

//检查相机的权限
- (void)checkAlbumPermission {

    
    if (![[AlbumManager manager] canUseCameraPermission] && ![[AlbumManager manager] canUsePhotosAlbumPermission]) {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                    message:@"没有开启使用相机和相册的权限"
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定", nil];
        alert.tag = 990;
        [alert show];
        return;
    }
    
    if (![[AlbumManager manager] canUseCameraPermission]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"相机权限受限,在设置>隐私>相机中打开此应用的使用权限"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        alert.tag = 993;
        [alert show];
        return;
    }

}

- (void)closeScanQRCode {
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//扫描二维码
- (void)scanQRCode {
    
    [[QRCodeManager manager] startScanQRCodeInView:self.view resultBlock:^(NSArray<NSString *> *strArray) {
        
        if ([scanResults length] != 0) return ;
        
        if ([strArray count] != 0) {
            
            scanResults = strArray[0];
            
            if ([scanResults rangeOfString:@"HXQRCODE"].location == NSNotFound) {
                [self showAlertView];
                return;
            }
            
            if (self.scanResult) {
                self.scanResult(scanResults);
                [self closeScanQRCode];
            }
        }
    }];
    //设置扫描的有效区域
    [[QRCodeManager manager] setInterstRect:CGRectMake((self.view.frame.size.width - 250)/2, 150, 250, 250)];
    //[[QRCodeManager manager] setInterstRect:self.view.bounds];
}

//识别二维码
- (void)discernQRCode {
    
    [[AlbumManager manager] transferAlbum:self onlyUsePhotoAlbum:YES albumBlock:^(BOOL canceled, UIImage *image) {
        
        if (!canceled) {
            [QRCodeManager detectorQRCodeImageWithSourceImage:image
                                            isDrawWRCodeFrame:NO
                                                completeBlock:^(NSArray *resultArray, UIImage *resultImage) {
                                                    
                                                    if ([resultArray count] == 0) {
                                                        [self showAlertView];
                                                        return;
                                                    }
                                                    
                                                    NSString *result = resultArray[0];
                                                    
                                                    if ([result rangeOfString:@"HXQRCODE"].location == NSNotFound) {
                                                        [self showAlertView];
                                                        return;
                                                    }
                                                    
                                                    if (self.scanResult) {
                                                        self.scanResult(result);
                                                        [self closeScanQRCode];
                                                    }
                                                }];
            
        }
    }];
    
}

- (void) showAlertView {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"没有识别到商户信息"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    alert.tag = 992;
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 990) {
        [self closeScanQRCode];
    } else if (alertView.tag == 991) {
        
    } else if (alertView.tag == 992) {
        scanResults = nil;
    } else if (alertView.tag == 993) {

    }
}

- (void)dealloc {
    scanResults = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
