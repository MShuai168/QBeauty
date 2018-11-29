//
//  UIAlertTool.h
//  HSP2P
//
//  Created by mxq on 16/4/28.
//  Copyright © 2016年 晓哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIAlertTool : NSObject

- (void)showAlertView:(UIViewController *)viewController :(NSString *)title :(NSString *)message :(NSString *)cancelButtonTitle :(NSString *)otherButtonTitle :(void (^)())confirm :(void (^)())cancle;

@end
