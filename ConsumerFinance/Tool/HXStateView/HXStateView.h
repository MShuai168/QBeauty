//
//  HXStateView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, showType) {
    showErrorType   = 0,//发生错误
    showRefeceType    = 1, //加载中....
    showNOdateType =2, //无数据
    showAbnormalType =3, // 发生异常
    showInformationType =4, //点击刷新
    showbillType =5, //点击刷新
    showRepayType =6, //点击刷新
};
@interface HXStateView : UIView
@property (nonatomic,assign)showType showType;
@property (nonatomic,copy)void(^submitBlock)();
-(id)initWithalertShow:(showType)showtype backView:(UIView *)view offset:(float)offset;
@end
