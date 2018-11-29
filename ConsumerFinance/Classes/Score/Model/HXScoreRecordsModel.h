//
//  HXScoreRecordsModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXScoreRecordsModel : NSObject
@property (nonatomic,strong)NSString * gmtModified;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * modifyType ;
@property (nonatomic,strong)NSString * monthDate;
@property (nonatomic,strong)NSString * monthGetScore;
@property (nonatomic,strong)NSString * monthSpendScore;
@property (nonatomic,strong)NSString * orderId ;
@property (nonatomic,strong)NSString * orderNo;
@property (nonatomic,strong)NSString * score;
@property (nonatomic,strong)NSString * scoreRecords;
@property (nonatomic,strong)NSString * scoreTime ;
@property (nonatomic,strong)NSString * taskName;
@property (nonatomic,strong)NSString * triggerId;
@end
