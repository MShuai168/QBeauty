//
//  ScanQRCodeViewController.h
//  QRCodeDemo
//
//  Created by 侯荡荡 on 16/8/26.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ScanQRCodeResult)(id object);

@interface ScanQRCodeViewController : UIViewController

@property (nonatomic, copy) ScanQRCodeResult scanResult;

@end
