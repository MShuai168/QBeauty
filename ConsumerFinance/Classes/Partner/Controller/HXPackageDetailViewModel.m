//
//  HXPackageDetailViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPackageDetailViewModel.h"
#import "HXPackageDetailModel.h"

@interface HXPackageDetailViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *packageDetails;
@property (nonatomic, copy) NSString *name;

@end

@implementation HXPackageDetailViewModel

- (instancetype)init {
    if (self == [super init]) {
        _packageDetails = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)requestWithSucess:(ReturnValueBlock)sucess failureBlock:(FailureBlock)failureBlock {
    [[HXNetManager shareManager] get:@"partnerPackage/detail" parameters:@{@"id":self.id} sucess:^(ResponseNewModel *responseNewModel) {
        if ([responseNewModel.status isEqualToString:@"0000"] || [responseNewModel.status isEqualToString:@"1301"]) {
            id obj = [responseNewModel.body objectForKey:@"vo"];
            if (obj) {
                HXPackageDetailJsonModel *model = [HXPackageDetailJsonModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"vo"]];
                
                _name = model.name;
                
                if (!([NSString isBlankString:model.availableTxt] && model.availableImgList.count == 0)) {
                    HXPackageDetailModel *detailModel = [[HXPackageDetailModel alloc] init];
                    detailModel.headerTitle = @"可选内容";
                    detailModel.detailContent = model.availableTxt;
                    detailModel.images = model.availableImgList;
                    [_packageDetails addObject:detailModel];
                }
                
                if (!([NSString isBlankString:model.packageTxt] && model.packageImgList.count == 0)) {
                    HXPackageDetailModel *detailModel = [[HXPackageDetailModel alloc] init];
                    detailModel.headerTitle = @"套餐内容";
                    detailModel.detailContent = model.packageTxt;
                    detailModel.images = model.packageImgList;
                    [_packageDetails addObject:detailModel];
                }
                
                if (!([NSString isBlankString:model.additionalTxt] && model.additionalImgList.count == 0)) {
                    HXPackageDetailModel *detailModel = [[HXPackageDetailModel alloc] init];
                    detailModel.headerTitle = @"附加内容";
                    detailModel.detailContent = model.additionalTxt;
                    detailModel.images = model.additionalImgList;
                    [_packageDetails addObject:detailModel];
                }
            }
            if ([responseNewModel.status isEqualToString:@"1301"]) {
                [KeyWindow displayMessage:responseNewModel.message];
            }
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
        if (sucess) {
            sucess();
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
