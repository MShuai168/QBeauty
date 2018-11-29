//
//  PopupView.h
//  买布易
//
//  Created by 张建 on 15/6/26.
//  Copyright (c) 2015年 张建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "AddressModel.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

typedef void(^AdressBlock) (AddressModel *provinceModel,AddressModel *cityModel);

@interface AddressPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,copy)AdressBlock block;


+ (instancetype)shareInstance;


@end
