//
//  HXProductDetailsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXPreDtoModel.h"
#import "HXMerDtoModel.h"
@interface HXProductDetailsModel : NSObject
@property (nonatomic,strong) HXPreDtoModel * preDtoModel;
@property (nonatomic,strong) HXMerDtoModel * merDtoModel;
@property (nonatomic,strong) NSString * proId;
@property (nonatomic,strong) NSArray * imgList;
@end
