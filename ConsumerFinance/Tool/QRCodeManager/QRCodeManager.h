//
//  QRCodeManager.h
//  QRCodeDemo
//
//  Created by 侯荡荡 on 16/8/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


@interface QRCodeManager : NSObject

+ (QRCodeManager *)manager;

/** 是否描绘二维码边框 */
@property (nonatomic, assign) BOOL isDrawFlag;


/**
 *  根据外界传递过来的内容, 生成一个二维码图片, 并且, 可以根据参数, 添加小头像,在生成后的二维码中间
 *
 *  @param content        二维码内容
 *  @param bigImageSize   大图片的尺寸
 *  @param smallImage     小图片
 *  @param smallImageSize 小图片的尺寸
 *
 *  @return 合成后的二维码图片
 */
+ (UIImage *)imageQRCodeWithContent:(NSString *)content bigImageSize:(CGFloat)bigImageSize smallImage:(UIImage *)smallImage smallImageSize:(CGFloat)smallImageSize;

/**
 *  识别一个图片中所有的二维码, 获取二维码内容
 *
 *  @param sourceImage       需要识别的图片
 *  @param isDrawWRCodeFrame 是否绘制识别到的边框
 *  @param completeBlock     (识别出来的结果数组, 识别出来的绘制二维码图片)
 */
+ (void)detectorQRCodeImageWithSourceImage:(UIImage *)sourceImage isDrawWRCodeFrame:(BOOL)isDrawWRCodeFrame completeBlock:(void(^)(NSArray *resultArray, UIImage *resultImage))completeBlock;

/**
 *  启动二维码扫描
 *
 *  @param inView      显示视频预览的view
 *  @param resultBlock 扫描结果回调
 */
- (void)startScanQRCodeInView:(UIView *)inView resultBlock:(void(^)(NSArray<NSString *> *strArray))resultBlock;

/**
 *  设置扫描识别的区域
 *
 *  @param sourceFrame 扫描区域
 */
- (void)setInterstRect:(CGRect)sourceFrame;

/**
 *  启动二维码扫描动画
 */
- (void)startScanQRCodeAnimation;

/**
 *  停止二维码扫描动画
 */
- (void)stopScanQRCodeAnimation;

@end
