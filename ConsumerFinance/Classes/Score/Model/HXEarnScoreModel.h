//
//  HXEarnScoreModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXEarnScoreModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *leftImage;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *score; // 通过此条件获取的积分
@property (nonatomic, assign) BOOL isCompleted; // 通过此条件，是否已经获取了积分
@property (nonatomic, strong) NSString *detail; //详细,如"+5积分"字样

@end
