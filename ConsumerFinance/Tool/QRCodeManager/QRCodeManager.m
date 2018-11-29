//
//  QRCodeManager.m
//  QRCodeDemo
//
//  Created by 侯荡荡 on 16/8/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "QRCodeManager.h"
#import "ScanAnimationLayer.h"

@interface QRCodeManager ()<AVCaptureMetadataOutputObjectsDelegate>

/** AVCaptureSession会话 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 输入设备: 摄像头 */
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/** 输出处理对象 */
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
/** 预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer;
/** 扫描到的二维码回调block,传递结果给外部 */
@property (nonatomic, copy) void(^scanResultBlock)(NSArray<NSString *> *strArray);
/** 动画图层 */
@property (nonatomic, strong) ScanAnimationLayer *animationLayer;

@end

@implementation QRCodeManager

+ (QRCodeManager *)manager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


/************************************************
 
 生成二维码的基本步骤:
 
 1.实例化二维码滤镜
 
 2.恢复滤镜的默认属性
 
 3.将字符串转换成NSData
 
 4.通过KVC设置滤镜inputMessage数据,通过KVC设置滤镜的 inputCorrectionLevel (容错率)
 
 5.获得滤镜输出的图像
 
 6.将CIImage转换成UIImage，并放大显示
 
 7.通过位图创建高清图片
 
 *************************************************/

#pragma mark - 生成二维码图片
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
+ (UIImage *)imageQRCodeWithContent:(NSString *)content bigImageSize:(CGFloat)bigImageSize smallImage:(UIImage *)smallImage smallImageSize:(CGFloat)smallImageSize
{
    // 1.将要生成的内容转码为UTF8编码
    NSData *strData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // 1.创建一个二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 1.1 恢复滤镜默认设置
    [filter setDefaults];
    
    // 2.设置滤镜的输入内容
    // 如果要给滤镜设置输入数据,只能使用KVC设置. key: inputMessage
    // 输入的数据只能传递NSData
    [filter setValue:strData forKey:@"inputMessage"];
    
    // 2.1 设置二维码的纠错率 key: inputCorrectionLevel
    // 纠错率等级: L, M, Q, H
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3.直接从二维码滤镜中获取需要的二维码图片
    CIImage *image = [filter outputImage];
    
    // 3.1 默认生成的二维码尺寸为 23x23 ,需要借助位图来处理方法图片, 获取一个高清的图片
    UIImage *newImage = [self createNonInterpolatedUIImageFormCIImage:image withSize:bigImageSize];
    
    // 3.2 判断是否有小图标,如果有小图标,合成小图标
    if (smallImage != nil) {
        newImage = [self createImageBigImage:newImage smallImage:smallImage sizeWH:smallImageSize];
    }
    
    return newImage;
}

/**
 *  根据两个图片,合成一个大图片
 *
 *  @param bigImage   大图的背景图片
 *  @param smallImage 小图标(居中)
 *  @param sizeWH     小图标的尺寸
 *
 *  @return 合成后的图片
 */
+ (UIImage *)createImageBigImage:(UIImage *)bigImage smallImage:(UIImage *)smallImage sizeWH:(CGFloat)sizeWH
{
    CGSize size = bigImage.size;
    
    // 1.开启一个图形山下文
    UIGraphicsBeginImageContext(size);
    
    // 2.绘制大图片
    [bigImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 3.绘制小图片
    CGFloat x = (size.width - sizeWH) * 0.5;
    CGFloat y = (size.height - sizeWH) *0.5;
    [smallImage drawInRect:CGRectMake(x, y, sizeWH, sizeWH)];
    
    // 4.取出合成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);

    return [UIImage imageWithCGImage:scaledImage];
    
}


/************************************************
 
 识别二维码基本步骤:
 
 1.创建一个上下文
 
 2.创建一个探测器
 
 3.转换原图片为 CIImage
 
 4.获取探测器识别的图像特征
 
 5.遍历图片特征, 获取数据
 
 6.绘制识别到的二维码边框
 
 7.传递识别的数据给外界.
 
 *************************************************/

#pragma mark - 识别二维码图片

/**
 *  识别一个图片中所有的二维码, 获取二维码内容
 *
 *  @param sourceImage       需要识别的图片
 *  @param isDrawWRCodeFrame 是否绘制识别到的边框
 *  @param completeBlock     (识别出来的结果数组, 识别出来的绘制二维码图片)
 */
+ (void)detectorQRCodeImageWithSourceImage:(UIImage *)sourceImage isDrawWRCodeFrame:(BOOL)isDrawWRCodeFrame completeBlock:(void(^)(NSArray *resultArray, UIImage *resultImage))completeBlock
{
    // 0.创建上下文
    CIContext *context = [[CIContext alloc] init];
    // 1.创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    
    // 2.直接开始识别图片,获取图片特征
    CIImage *imageCI = [[CIImage alloc] initWithImage:sourceImage];
    NSArray<CIFeature *> *features = [detector featuresInImage:imageCI];
    
    // 3.读取特征
    UIImage *tempImage = sourceImage;
    NSMutableArray *resultArray = [NSMutableArray array];
    for (CIFeature *feature in features) {
        
        CIQRCodeFeature *tempFeature = (CIQRCodeFeature *)feature;
        
        [resultArray addObject:tempFeature.messageString];
        
        if (isDrawWRCodeFrame) {
            tempImage = [self drawQRCodeFrameFeature:tempFeature toImage:tempImage];
        }
    }
    
    // 4.使用block传递数据给外界
    completeBlock(resultArray, tempImage);
    
}

/**
 *  根据一个特征, 对给定图片, 进行绘制边框
 *
 *  @param feature 特征对象
 *  @param toImage 需要绘制的图片
 *
 *  @return 绘制好边框的图片
 */
+ (UIImage *)drawQRCodeFrameFeature:(CIQRCodeFeature *)feature toImage:(UIImage *)toImage
{
    // bounds,相对于原图片的一个大小
    // 坐标系是以左下角为(0, 0)
    CGRect bounds = feature.bounds;
    
    CGSize size = toImage.size;
    // 1.开启图形上下文
    UIGraphicsBeginImageContext(size);
    
    // 2.绘制图片
    [toImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 3.反转上下文坐标系
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -size.height);
    
    // 4.绘制边框
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
    path.lineWidth = 12;
    [[UIColor redColor] setStroke];
    [path stroke];
    
    // 4.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


/************************************************
 
 扫描二维码基本步骤:
 
 1.实例化拍摄设备
 
 2.设置输入设备
 
 3.设置元数据输出处理对象
 
    3.1 实例化拍摄元数据输出
    3.2 设置输出数据代理
 
 4.添加拍摄会话
 
 5.视频预览图层(不是必须)
 
 6.启动会话
 
 7.监听元数据处理后的结果
 
 *************************************************/

#pragma mark - 扫描二维码

/**
 *  启动二维码扫描
 *
 *  @param inView      显示视频预览的view
 *  @param resultBlock 扫描结果回调
 */
- (void)startScanQRCodeInView:(UIView *)inView resultBlock:(void(^)(NSArray<NSString *> *strArray))resultBlock
{
    // 1.记录block,在核实的地方执行
    self.scanResultBlock = resultBlock;
    
    // 2.在添加之前,先判断当前会话是否可以添加
    if ([self.session canAddInput:self.input] &&[self.session canAddOutput:self.output]) {
        
        [self.session addInput:self.input];
        [self.session addOutput:self.output];
        
        // 设置元数据处理的结果类型
        // 如果只需要处理二维码, 那么只需要把处理类型改为二维码类型就可以
        // output.availableMetadataObjectTypes
        // 这个设置, 一定要在会话添加输出处理之后, 才能设置, 否则, 扫描不到, 无法处理
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }
    
    // 3.1 添加一个视频预览图层
    self.preLayer.frame = inView.bounds;
    
    CGFloat animationW = self.preLayer.frame.size.width;
    CGFloat animationH = self.preLayer.frame.size.height;
    
    [self createAnimationLayer:CGRectMake((animationW * 0.3) / 2,
                                          (animationH * 0.6) / 2,
                                          animationW * 0.7,
                                          animationH * 0.4)];
    
    NSArray *subLayers = inView.layer.sublayers;
    if (subLayers.count == 0) {
        [inView.layer insertSublayer:self.preLayer atIndex:0];
        [self.session startRunning];
        return;
    }
    
    if (![subLayers containsObject:self.preLayer]) {
        [inView.layer insertSublayer:self.preLayer atIndex:0];
    }
    
    // 4.开始扫描(启动会话)
    [self.session startRunning];
    
}

/**
 *  设置扫描识别的区域
 *
 *  @param sourceFrame 扫描区域
 */
- (void)setInterstRect:(CGRect)sourceFrame
{
    
    // 3.2 设置扫描识别的区域
    // 坐标系: 0, 0 是右上角
    // 横屏状态下的坐标
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat x = sourceFrame.origin.x / bounds.size.width;
    CGFloat y = sourceFrame.origin.y / bounds.size.height;
    CGFloat w = sourceFrame.size.width / bounds.size.width;
    CGFloat h = sourceFrame.size.height / bounds.size.height;
    
    self.output.rectOfInterest = CGRectMake(y, x, h, w);
    
    [self createAnimationLayer:sourceFrame];
}

/**
 *  创建扫描动画
 */
- (void)createAnimationLayer:(CGRect)frame {
    
    if (self.animationLayer) [self.animationLayer removeFromSuperlayer];
    
    self.animationLayer = [[ScanAnimationLayer alloc] initWithBounds:self.preLayer.bounds
                                                     backgroundColor:[UIColor clearColor]
                                                           focusRect:frame];
    [self.preLayer addSublayer:self.animationLayer];
    
    CATextLayer *label = [CATextLayer layer];
    [label setFrame:CGRectMake((CGRectGetWidth(self.animationLayer.frame) - 200)/2,
                              CGRectGetMaxY(frame) + 10,
                              200, 18)];
    [label setString:@"将二维码放入框中，即可自动扫描"];
    [label setFontSize:12.f];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[UIColor whiteColor].CGColor];
    [label setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
    [label setContentsScale:[UIScreen mainScreen].scale];
    [self.animationLayer addSublayer:label];
    
}


// 移除二维码边框
- (void)removeQRCodeFrame
{
    NSArray *subLayers = self.preLayer.sublayers;
    if (subLayers.count == 0) {
        return;
    }
    
    for (CALayer* layer in subLayers) {
        
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

// 绘制二维码边框
- (void)drawQRCodeFrameWithObj:(AVMetadataMachineReadableCodeObject *)obj
{
    
    //corners, 是二维码的四个角, 但是坐标如果想要使用, 需要进行转换
    //print(obj.corners)
    
    // 1. 必须使用视频预览图层, 对坐标进行转换
    AVMetadataMachineReadableCodeObject *resultObj = (AVMetadataMachineReadableCodeObject *)[self.preLayer transformedMetadataObjectForMetadataObject:obj];

    // 根据四个点,绘制一个曲线
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 6;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 对四个点的数据进行遍历, 并且根据里面的字典, 创建对应的point
    NSInteger pointCount = resultObj.corners.count;
    for (int i = 0; i < pointCount; i++) {
        
        CFDictionaryRef pointDict = (__bridge CFDictionaryRef)resultObj.corners[i];
        
        CGPoint point = CGPointZero;
        CGPointMakeWithDictionaryRepresentation(pointDict, &point);
        
        // 绘制贝塞尔曲线(二维码边框)
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
        
    }
    
    [path closePath];
    
    layer.path = path.CGPath;
    
    // 添加形状图层到需要展示的图层上面
    [self.preLayer addSublayer:layer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate代理

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 移除之前的边框
    [self removeQRCodeFrame];
    
    NSMutableArray *resultStrs = [NSMutableArray array];
    // 以后, 如果扫描到其他码制, 也会调用这个方法, 所以, 在这里, 如果我们只是处理二维码, 需要对元数据数据类型, 进行判断处理
    for (NSObject *obj in metadataObjects) {
        
        if ([obj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            
            // corners, 是二维码的四个角, 但是坐标如果想要使用, 需要进行转换
            // stringValue: 就是二维码对应的数据信息
            AVMetadataMachineReadableCodeObject *resultObj = (AVMetadataMachineReadableCodeObject *)obj;
            
            [resultStrs addObject:resultObj.stringValue];
            
            if (self.isDrawFlag) {
                [self drawQRCodeFrameWithObj:resultObj];
            }
        }
    }
    
    if (self.scanResultBlock) {
        self.scanResultBlock(resultStrs);
    }
}

#pragma mark - 懒加载

- (AVCaptureSession *)session {
    if (_session == nil) {
        // 1.创建一个会话,链接输入和输出
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureDeviceInput *)input {
    
    if (_input == nil) {
        
        // 1.获取摄像头设备,并且作为输入设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error;
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
        
        if (error != nil) {
            NSLog(@"%@", error);
            return nil;
        }
    }
    
    return _input;
}

- (AVCaptureMetadataOutput *)output {
    
    if (_output == nil) {
        
        // 1.设置输出处理
        // 元数据处理对象: 元数据,就是一种中间数据
        _output = [[AVCaptureMetadataOutput alloc] init];
        // 2.设置元数据处理dialing,接收处理结果
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    return _output;
}

- (AVCaptureVideoPreviewLayer *)preLayer {
    
    if (_preLayer == nil) {
        _preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    }
    
    return _preLayer;
}

#pragma mark - 扫描动画
- (void)startScanQRCodeAnimation {
    if (self.animationLayer) [self.animationLayer startAnimate];
}

- (void)stopScanQRCodeAnimation {
    if (self.animationLayer) [self.animationLayer stopAnimate];
}

@end
