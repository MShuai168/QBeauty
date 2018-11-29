//
//  AlbumManager.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/19.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXSheet.h"

typedef void (^TransferAlbumBlock)(BOOL canceled, UIImage *image);

@interface AlbumManager : NSObject
<HXSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, copy)TransferAlbumBlock  albumBlock;
@property (nonatomic, strong) UIViewController *currentController;
@property (nonatomic, assign) BOOL onlyUsePhotoAlbum;

+ (AlbumManager *)manager;

/*
 * @bref 调取手机系统相册和系统相机
 * @para Controller 调取系统相册和系统相机的当前控制器
 * @para usePhotoAlbum 是否只从相册读取
 * @para contactBlock 拿到图片后的回调
 * return void
 */
- (void)transferAlbum:(UIViewController *)controller onlyUsePhotoAlbum:(BOOL)usePhotoAlbum albumBlock:(TransferAlbumBlock)block;

/*!
 * @brief 判断系统相机是否损坏
 * @return 系统相机是否损坏
 */
- (BOOL)canUseCamera;

/*!
 * @brief 判断是否有使用系统相机的权限
 * @return 是否有使用系统相机的权限
 */
- (BOOL)canUseCameraPermission;

/*!
 * @brief 判断是否有使用系统相册的权限
 * @return 是否有使用系统相册的权限
 */
- (BOOL)canUsePhotosAlbumPermission;

@end
