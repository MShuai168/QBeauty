//
//  AddressWithZonesPickView.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "AddressModel.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

typedef void(^AdressWithZoneBlock) (AddressModel *provinceModel, AddressModel *cityModel, AddressModel *zoneModel);
typedef void(^dismiss)();

@interface AddressWithZonesPickView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) AdressWithZoneBlock block;
@property (nonatomic, copy) dismiss dismiss;

+ (instancetype)shareInstanceWithAnimate:(BOOL)animate;

@end
