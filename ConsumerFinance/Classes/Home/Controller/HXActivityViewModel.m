//
//  HXActivityViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXActivityViewModel.h"
#import "HXActivityModel.h"

@interface HXActivityViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *activities;

@end

@implementation HXActivityViewModel

- (instancetype)init {
    if (self == [super init]) {
        _activities = [[NSMutableArray alloc] init];
        
        [self request];
    }
    return self;
}

- (void)request {
    NSDictionary *body = @{@"cityId" : @"",
                           @"locationType" : @"40"
                           };
    
    [[HXNetManager shareManager] get:GetBannerUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSMutableArray *arr = [responseNewModel.body objectForKey:@"AdvertisementList"];
            NSMutableArray *tmp = [[NSMutableArray alloc] init];
            if (arr) {
                for (NSDictionary * dic in arr) {
                    HXActivityModel *model = [HXActivityModel mj_objectWithKeyValues:dic];
                    [tmp addObject:model];
                }
                self.activities = tmp;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
