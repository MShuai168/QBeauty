//
//  HXHomeCollectionViewCellViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HXHomeCollectionViewCellStyle) {
    HXHomeCollectionViewCellStyleCompany,
    HXHomeCollectionViewCellStyleProject
};

@interface HXHomeCollectionViewCellViewModel : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float stars;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) HXHomeCollectionViewCellStyle cellStyle;

@end
