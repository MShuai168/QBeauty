//
//  HXEvaluateModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXEvaluateModel : NSObject
@property(nonatomic,strong)NSString * commentId;//评价id
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * merName;//商户名称
@property(nonatomic,strong)NSString * orderNo; //订单号
@property(nonatomic,strong)NSString * updateDate;//完成时间
@property(nonatomic,strong)NSString * updatedAt;
@property(nonatomic,strong)NSString * url;
@end
