//
//  HXPackageModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPackageModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) BOOL isChoosed;

@end
