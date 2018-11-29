//
//  AlbumManager.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/19.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "AlbumManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation AlbumManager

+ (AlbumManager *)manager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)transferAlbum:(UIViewController *)controller onlyUsePhotoAlbum:(BOOL)usePhotoAlbum albumBlock:(TransferAlbumBlock)block {
    
    if (usePhotoAlbum) {
        
        if(![self canUsePhotosAlbumPermission]){
            [[[UIAlertView alloc] initWithTitle:@"提示"
                                        message:@"相册权限受限,在设置>隐私>相册中打开此应用的使用权限"
                                       delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定", nil] show];
            return;
        }
        UIImagePickerController *imgController = [[UIImagePickerController alloc] init];
        imgController.delegate = self;
        imgController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        
        
        [controller presentViewController:imgController animated:YES completion:nil];
        
    } else {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [[HXSheet shareSheet] cc_actionSheetWithSelectArray:@[@"拍照",@"从相册选择"]
                                                    cancelTitle:@"取消"
                                                       delegate:self];
        }else {
            [[HXSheet shareSheet] cc_actionSheetWithSelectArray:@[@"从相册选择"]
                                                    cancelTitle:@"取消"
                                                       delegate:self];
        }
    }
    
    self.currentController = controller;
    self.albumBlock = block;
}

- (BOOL)canUseCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return YES;
    
    return NO;
}

- (BOOL)canUseCameraPermission {
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted ||
       authStatus == AVAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}

- (BOOL)canUsePhotosAlbumPermission {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if(author == ALAuthorizationStatusRestricted ||
       author == ALAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}


#pragma mark - HXSheetDelegate

- (void)cc_actionSheetDidSelectedIndex:(NSInteger)index {
    
    NSUInteger sourceType = 0;
    NSString *alert = [NSString string];
    
    if ([self canUseCamera]) {
        switch (index) {
            case 0: return; break;
            case 1: {
                if(![self canUseCameraPermission]){
                    alert = @"相机权限受限,在设置>隐私>相机中打开此应用的使用权限";
                }
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
                break;
            case 2: {
                if(![self canUsePhotosAlbumPermission]){
                    //无权限
                    alert = @"相册权限受限,在设置>隐私>相册中打开此应用的使用权限";
                }
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
                break;
            default:
                break;
        }
    }else{
        if (index == 0) {
            return;
        }else{
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    if ([alert length] != 0){
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:alert
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定", nil]
         show];
        return;
    }
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    //controller.allowsEditing = YES;
    controller.sourceType = sourceType;
    
    [self.currentController presentViewController:controller animated:YES completion:^{
        
    }];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.albumBlock) self.albumBlock (NO, image);
}

@end
