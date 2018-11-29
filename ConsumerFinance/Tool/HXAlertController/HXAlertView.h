//
//  YBAlertView.h
//  YBAlertView_Demo
//
//  Created by Jason on 16/1/12.
//  Copyright © 2016年 www.jizhan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "HXButton.h"
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
typedef void(^ClickAlertControllerBlock)(NSString * contentMsg);

@protocol HXAlertViewDelegate <NSObject>

- (void) sendSMS:(HXButton*)but;

@end
@interface HXAlertView : UIView


@property (nonatomic,strong)NSString *payButtonTitle;

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *placeHoderStr;
@property (nonatomic,copy) ClickAlertControllerBlock clickAlertControllerBlock;


@property (nonatomic, weak) id <HXAlertViewDelegate> delegate;

- (void)show;
- (void)close;

@end
