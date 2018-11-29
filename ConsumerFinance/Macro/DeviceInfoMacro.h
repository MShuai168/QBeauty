////
////  DeviceInfoMacro.h
////  QianXiang
////
////  Created by 侯荡荡 on 16/3/24.
////  Copyright © 2016年 Hou. All rights reserved.
//

#ifndef DeviceInfoMacro_h
#define DeviceInfoMacro_h
//
////获取Version对外显示版本号
#define SHORT_VERSION                              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
////获取Build构建版本号
#define BUILD_VERSION                              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IsEqualToSuccess(str)                     [str isEqualToString: @"0000"]

////获取UUID
//#define K_UUID                      [UIDevice currentDevice].identifierForVendor.UUIDString
//
////获取当前时间戳
#define K_CURRENT_TIMESTAMP         [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

////主屏幕的高度
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
////主屏幕的宽度
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width


/*
机型               尺寸     逻辑缩放因子(UIKit Scale factor）  实际缩放因子(Native Scale factor）   屏幕宽高     屏幕分辨率      PPI
3GS              3.5寸            1.0                                     1.0                 320x480     320x480      123
4(S)             3.5寸            2.0                                     2.0                 320x480     640x960      326
5(C)／5(S/SE)      4寸            2.0                                      2.0                320x568     640x1136      326
6(S)／7／8        4.7寸            2.0                                     2.0                375x667     750x1334      326
6(S)+／7+／8+     5.5寸            3.0                                     2.608              414x736     1080x1920     401
X/XS             5.8寸            3.0                                     3.0                375x812     1125x2436     458
XS Max           6.5寸            3.0                                     3.0                414x896     1242x2688     458
XR               6.1寸            2.0                                     2.0                414x896     828x1792      326

 //需要注意的地方是:6(S)+／7+／8+的时候，实际的缩放因子并不等于逻辑上的缩放因子。所以，他的屏幕分辨率是1080x1920而不是1242x2208。
*/

//3.5寸  4S    320X480
//4.0寸  5S、5C    320X568
//4.7寸  6、7、8     375X667
//5.5寸  6Plus/7Plus/8Plus     414X736
//5.8寸  iPhoneX       375X812
//5.8 英寸    iPhone XS   375pt * 812pt (@3x)；
//6.1 英寸    iPhone XR   414pt * 896pt (@2x)；
//6.5 英寸    iPhone XS Max   414pt * 896pt (@3x)；

///**
// *  1 判断是否为3.5inch      640*960像素
// */
//#define ONESCREEN ([UIScreen mainScreen].bounds.size.height == 480)
///**
// *  2 判断是否为4inch        640*1136像素
// */
#define TWOSCREEN ([UIScreen mainScreen].bounds.size.height == 568)
///**
// *  3 判断是否为4.7inch   375*667   750*1334像素
// */
//#define THREESCREEN ([UIScreen mainScreen].bounds.size.height == 667)
///**
// *  4 判断是否为5.5inch   414*736   1080*1920像素
// */
//#define FOURSCREEN ([UIScreen mainScreen].bounds.size.height == 736)
///**
// *  5 判断是否为5.8inch   2436 x 1125像素  iphone X
// */
#define iphone_X ([UIScreen mainScreen].bounds.size.height >= 812)
//
//
////特殊部分使用比例限制（默认尺寸：iPhone6/iPhone6s）
#define showScale                   (SCREEN_WIDTH / 375.0f)
////显示比例
#define displayScale               1//(SCREEN_WIDTH / 375.0f)//375
////字体比例
#define fontScale                   ((ceil(showScale) - 1) * 2)
//
//
////系统控件的默认高度
//#define STATUSBAR_HEIGHT            (20.0f)
//#define NAVIGATIONBAR_HEIGHT        (44.0f)
#define STA_NAV_HEIGHT              (64.0f)
#define TABBAR_HEIGHT               (49.0f)
//#define CELL_DEFAULT_HEIGHT         (44.0f)
//
////中英状态下键盘的高度
//#define EN_KEYBOARD_HEIGHT          (216.0f)
//#define CN_KEYBOARD_HEIGHT          (252.0f)
//
//
#define ATTR_DICTIONARY(color, size)                    @{NSForegroundColorAttributeName : color,\
                                                                     NSFontAttributeName : NormalFontWithSize(size)}

#define ATTR_DICTIONARY2(color, bg_color, size)         @{NSForegroundColorAttributeName : color,\
                                                          NSBackgroundColorAttributeName : bg_color,\
                                                                     NSFontAttributeName : NormalFontWithSize(size)}

#define ATTR_DICTIONARY3(color, font)                   @{NSForegroundColorAttributeName : color,\
                                                                     NSFontAttributeName : font}

#define KeyWindow                   [UIApplication sharedApplication].keyWindow


//
#define SYSTEM_VERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//// 判断是否是iPhone X
//#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//
#endif /* DeviceInfoMacro_h */
