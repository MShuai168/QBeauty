//
//  HXBannerModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBannerModel : NSObject
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * imgUrl;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * jumpType;//跳转标志
@property (nonatomic,strong)NSString * jumpParam; //跳转参数
@end
