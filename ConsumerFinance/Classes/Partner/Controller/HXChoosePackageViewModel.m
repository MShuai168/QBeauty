//
//  HXChoosePackageViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/30.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXChoosePackageViewModel.h"
#import "HXPackageModel.h"

@interface HXChoosePackageViewModel()

@property (nonatomic, strong) NSMutableArray *packagePersonArray;
@property (nonatomic, strong) NSMutableArray *packageShopArray;
@property (nonatomic, strong, readwrite) NSMutableDictionary *packageDic;

@end

@implementation HXChoosePackageViewModel

- (instancetype)init {
    if (self == [super init]) {
        _packageShopArray = [[NSMutableArray alloc] init];
        _packagePersonArray = [[NSMutableArray alloc] init];
        _packageDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)request {
    [MBProgressHUD showMessage:nil toView:nil];
    [[HXNetManager shareManager] get:@"partnerPackage/getList" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:nil];
        _packagePersonArray = [HXPackageModel mj_objectArrayWithKeyValuesArray:[responseNewModel.body objectForKey:@"zVoList"]];
        _packageShopArray = [HXPackageModel mj_objectArrayWithKeyValuesArray:[responseNewModel.body objectForKey:@"pVoList"]];
        
        [_packageDic setObject:_packagePersonArray forKey:@"0"];
        [_packageDic setObject:_packageShopArray forKey:@"1"];
        
        self.packageDic = _packageDic;
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:nil];
    }];
}

- (NSString *)getSelectedId {
    __block NSString *selectedId = nil;
    [_packagePersonArray enumerateObjectsUsingBlock:^(HXPackageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChoosed == YES) {
            selectedId = obj.id;
            *stop = YES;
        }
    }];
    
    if ([NSString isBlankString:selectedId]) {
        [_packageShopArray enumerateObjectsUsingBlock:^(HXPackageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isChoosed == YES) {
                selectedId = obj.id;
                *stop = YES;
            }
        }];
    }
    return selectedId;
}

- (void)buyPackageWithSucess:(buyPackageBlock)sucess failure:(FailureBlock)failure {
    [MBProgressHUD showMessage:nil toView:nil];
    NSString *selectedId = [self getSelectedId];

    NSDictionary *parameters = @{@"id":selectedId,@"inviterCode":self.inviterCode?:@""};
    [[HXNetManager shareManager] post:@"partnerPackage/buy" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:nil];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            id orderId = [responseNewModel.body valueForKey:@"orderId"];
            sucess(orderId);
        } else {

        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:nil];
        if (failure) {
            failure();
        }
    }];

}

- (void)resetModel {
    [self.packagePersonArray enumerateObjectsUsingBlock:^(HXPackageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isChoosed = NO;
    }];
    [self.packageShopArray enumerateObjectsUsingBlock:^(HXPackageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isChoosed = NO;
    }];
}

@end
