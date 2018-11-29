//
//  HXPackageDetailModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPackageDetailModel : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *detailContent;
@property (nonatomic, strong) NSArray *images;

@end

@interface HXPackageDetailJsonModel: NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *availableTxt; //可选套餐描述文本
@property (nonatomic, strong) NSString *packageTxt; //套餐描述文本
@property (nonatomic, strong) NSString *additionalTxt; //附加内容文本

@property (nonatomic, strong) NSArray *availableImgList; //可选套餐描述文本图片
@property (nonatomic, strong) NSArray *packageImgList; //套餐描述文本图片
@property (nonatomic, strong) NSArray *additionalImgList; //附加内容文本图片

@end
