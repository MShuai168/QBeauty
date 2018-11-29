//
//  HXEarnScoreViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEarnScoreViewModel.h"
#import "HXEarnScoreModel.h"

@interface HXEarnScoreViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *scoreWayArray;

@end

@implementation HXEarnScoreViewModel

- (instancetype)init {
    if (self == [super init]) {
        _scoreWayArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)request {
    [[HXNetManager shareManager] get:GetTaskListUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSArray *array = [responseNewModel.body objectForKey:@"tasks"];
            self.scoreWayArray = [HXEarnScoreModel mj_objectArrayWithKeyValuesArray:array];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
