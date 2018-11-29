//
//  HXShoppingCartViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/14.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXShoppingCartViewModel.h"
#import "HXRecomendModel.h"


@implementation HXShoppingCartViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.page = 1;
        self.carriage = @"0.00";
        self.money = @"0.00";
        self.integration = 0.00;
    }
    return self;
}
-(void)archiveShopCarInformationWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
//    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:QueryShoppingCartUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.carriage = @"0.00";
            self.integration = 0.00;
            self.money = @"0.00";
            [self.shopCartNumberArr removeAllObjects];
            [self.stopShopArr removeAllObjects];
            self.addressModel = [HXShopAddressModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"defaultAddress"]];
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"shoppingCart"]) {
                
                HXShopCarModel * model = [HXShopCarModel mj_objectWithKeyValues:dic];
                model.selectedBool = YES;
                if ([model.proOnshelfStatus intValue]!=2) {
                    if ([model.stock intValue]==0&&model.stock.length!=0) {
                        model.proOnshelfStatus = @"3";
                    }
                }
                if ([model.proOnshelfStatus isEqualToString:@"1"] && model.proOnshelfStatus.length!=0) {
                    if (model) {
                        [self.shopCartNumberArr addObject:model];
                    }
                    //                                                                 if ([model.proNum intValue]>=[model.stock intValue]) {
                    //                                                                     model.proNum = model.stock;
                    //                                                                 }
                    self.carriage = [self.carriage doubleValue] >= [model.shippingExpense doubleValue] ?self.carriage:model.shippingExpense;
                    //                                                                 self.integration = self.integration + [model.score doubleValue]*[model.proNum intValue];
                    //                                                                 self.money = self.money + [model.price doubleValue]*[model.proNum intValue];
                }else {
                    if (model) {
                        
                        [self.stopShopArr addObject:model];
                    }
                }
            }
            
            returnBlock();
        }else {
            failBlock();
        }
        
    } failure:^(NSError *error) {
        failBlock();
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
}

-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"pageSize":@"10",
                           @"strRecommendOnly":@"false"
                           };
    [[HXNetManager shareManager] get:RecommendProductUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            if (self.page==1) {
                [self.recomendArr removeAllObjects];
            }
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"recommendProductList"]) {
                HXShopCarModel * model = [HXShopCarModel mj_objectWithKeyValues:dic];
                if (model) {
                    
                    [self.recomendArr addObject:model];
                }
            }
            returnBlock();
        }else {
            failBlock();
        }
        
    } failure:^(NSError *error) {
        failBlock();
    }];
    
    
    
    
}

-(void)changeShopCarNumberWithAddBool:(BOOL)addBool model:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    int number = [model.proNum intValue];
    number = addBool?++number:--number;
    NSDictionary *body = @{
                           @"skuId":model.skuId.length!=0?model.skuId:@"",
                           @"proNum":[NSString stringWithFormat:@"%d",number]
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:ChangeShopCart parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            model.proNum = [NSString stringWithFormat:@"%d",number];
            returnBlock();
        }else {
            failBlock();
        }
        
    } failure:^(NSError *error) {
        failBlock();
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
}

-(void)updateShopCarNumberWithModel:(HXShopCarModel *)model number:(NSInteger)number returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"skuId":model.skuId.length!=0?model.skuId:@"",
                           @"proNum":[NSString stringWithFormat:@"%ld",number]
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:ChangeShopCart parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            model.proNum = [NSString stringWithFormat:@"%ld",number];
            returnBlock();
        }else {
            failBlock();
        }
    } failure:^(NSError *error) {
        failBlock();
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
}

-(void)addShopCarNumberWithModel:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    
    NSDictionary *body = @{
                           @"skuId":model.skuId.length!=0?model.skuId:@"",
                           @"proNum":[NSString stringWithFormat:@"%d",1]
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:AddShoppingCart parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock();
        }else {
            failBlock();
        }
    } failure:^(NSError *error) {
        failBlock();
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
    
    
}

-(void)removeShopCartInformationWithModel:(HXShopCarModel *)model returnBlock:(ReturnValueBlock)returnBlock {

    NSDictionary *body = @{
                           @"skuIds":model.skuId.length!=0?model.skuId:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:DeleteShoppingCart parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock();
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
    
    
    
}

-(void)placeOrderWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSMutableArray * shopArr = [[NSMutableArray alloc] init];
    for (HXShopCarModel * model in self.shopCartNumberArr) {
        if (model.selectedBool && [model.stock intValue]!=0) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:model.skuId.length!=0?model.skuId:@"" forKey:@"skuId"];
            [dic setObject:model.proNum.length!=0?model.proNum:@"0" forKey:@"buyNum"];
            [dic setObject:model.price.length!=0?model.price:@"0.00" forKey:@"cash"];
            [dic setObject:model.score.length!=0?model.score:@"0" forKey:@"socre"];
            [dic setObject:model.proNum.length!=0?model.proName:@"" forKey:@"productName"];
            [dic setObject:model.specOne.length!=0?model.specOne:@"" forKey:@"specOne"];
            [dic setObject:model.specTwo.length!=0?model.specTwo:@"" forKey:@"specTwo"];
            [dic setObject:model.specThree.length!=0?model.specThree:@"" forKey:@"specThree"];
            [dic setObject:model.markPrice.length!=0?model.markPrice:@"0.00" forKey:@"marketCash"];
            [shopArr addObject:dic];
        }
    }
    NSString * shopStr = [shopArr mj_JSONString];
    NSDictionary *body = @{
                           @"deliveryPhone":self.addressModel.phone.length!=0?self.addressModel.phone:@"",
                           @"deliveryReceiver":self.addressModel.receiver.length!=0?self.addressModel.receiver:@"",
                           @"deliveryAddress":self.addressModel.address.length!=0?self.addressModel.address:@"",
                           @"skuList":shopStr.length!=0?shopStr:@"",
                           @"totalCash":[NSString stringWithFormat:@"%@",self.money],
                           @"totalScore":[NSString stringWithFormat:@"%.lf",self.integration],
                           @"deliveryExpense":[NSString stringWithFormat:@"%@",self.carriage]
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:PlaceOrderUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock(responseNewModel);
        }else {
            failBlock(responseNewModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(nil);
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
    
    
    
}
-(void)querypaymentWithReturnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {

    NSDictionary *body = @{
                           @"orderNo":self.orderNo.length!=0?self.orderNo:@""
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] get:QueryPayResultUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            returnBlock(responseNewModel);
        }else {
            
            failBlock(responseNewModel);
        }
        
    } failure:^(NSError *error) {
        failBlock(nil);
        [MBProgressHUD hideHUDForView:self.controller.view];
    }];
    
    
}

-(NSMutableArray *)recomendArr {
    if (_recomendArr==nil) {
        _recomendArr = [[NSMutableArray alloc] init];
    }
    return _recomendArr;
}
-(NSMutableArray *)shopCartNumberArr {
    if (_shopCartNumberArr==nil) {
        _shopCartNumberArr = [[NSMutableArray alloc] init];
        
    }
    
    return _shopCartNumberArr;
}
-(NSMutableArray *)stopShopArr {
    if (_stopShopArr == nil) {
        _stopShopArr = [[NSMutableArray alloc] init];
    }
    return _stopShopArr;
    
}
    
@end
