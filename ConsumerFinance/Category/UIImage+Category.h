//
//  UIImage+Category.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/27.
//  Copyright © 2016年 Hou. All rights reserved.

#import <UIKit/UIKit.h>


@interface UIImage (Category)
+ (UIImage*) imageWithColor:(UIColor*)color;
+ (UIImage*) grayscaleImage:(UIImage*)image;
- (UIImage*) imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*) resizableImage:(UIEdgeInsets)insets;
- (UIImage*) imageWithColor:(UIColor *)color;
- (UIImage*) tintedImageWithColor:(UIColor*)color;
/**
 * 修发图片大小
 */
+ (UIImage*) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
/** 
 * 获取图片的格式
 */
+ (NSString *)typeForImageData:(NSData *)data;
/**
 *  根据图片大小动态调整图片
 *
 *  @param source_image 要调整的图片对象
 *  @param maxSize      最大多少“KB”
 *
 *  @return 调整后的图片二进制对象
 */
+ (NSData *)resetSizeOfImageDataWithSourceImage:(UIImage *)source_image maxSize:(NSInteger)maxSize;

/**
 获取SD缓存图片

 @param url url路径
 @return 图片
 */
+(UIImage*)imageFromSdcache:(NSString *)url;
@end


@interface UIImage (Blur)
- (UIImage*) boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end


@interface UIImage (ImageEffects)
- (UIImage*) applyLightEffect;
- (UIImage*) applyExtraLightEffect;
- (UIImage*) applyDarkEffect;
- (UIImage*) applyBlurEffect;
- (UIImage*) applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage*) applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;
@end


@interface UIImage (Compressed)
- (UIImage*) scaleToSize:(UIImage *)img size:(CGSize)size;
@end


@interface UIImage (Additions)
- (UIImage *)resizableImage;
// opaque 渲染是否透明
+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size;
+ (UIImage *)roundedImageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size shape:(UIBezierPath *)shape;
- (UIImage *)fixOrientation;
@end


