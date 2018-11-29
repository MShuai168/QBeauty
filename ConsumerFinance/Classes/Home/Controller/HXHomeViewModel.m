//
//  HXHomeViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXHomeViewModel.h"
#import "LetterListModel.h"
#import "VoListModel.h"
#import "HXRecommendModel.h"
#import "HXProjectModel.h"
#import "HXBannerModel.h"
#import "HXShopCarModel.h"
#import "DtoListModel.h"

@implementation HXHomeViewModel

- (instancetype)initWithController:(UIViewController *)controller {
    if (self == [super initWithController:controller]) {
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        if (city) {
            self.locationCity = city;
        }
    }
    return self;
}

- (void)needShowActivateView {
    // 第一跌代暂时不做额度激活
    if (![[AppManager manager] isOnline]) {
        // 未登陆
        self.isHiddenActivateView = NO;
        self.canActivate = YES;
    }else {
        if ([self.creditModel.isActivate boolValue]) {
           self.isHiddenActivateView = YES;
        }
        self.canActivate = NO;
    }
}

-(void)archiveAd:(ReturnValueBlock)returnBlock {
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    LetterListModel * letterModel;
    if (city) {
        letterModel = [VoListModel inquiryLetterModelWithName:city];
    }
    NSDictionary *body = @{@"cityId" : letterModel.id ? letterModel.id :@"",
                           @"locationType" : @"10"
                          };
    [[HXNetManager shareManager] get:GetBannerUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in [responseNewModel.body objectForKey:@"AdvertisementList"]) {
                
                HXBannerModel * model = [HXBannerModel mj_objectWithKeyValues:dic];
                if (model) {
                    
                    [arr addObject:model];
                }
                
            }
            self.adUrlStr = [responseNewModel.body objectForKey:@"activityBanner"];
            if (arr.count!=0) {
                
                self.bannarArr = arr;
            }
            returnBlock();
        }
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark -- 猜你喜欢
//更换城市需要清空猜你喜欢数据
-(void)archiveRecently:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock{
    
    NSDictionary *head = @{@"tradeCode" : @"0179",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"cityId":self.letterModel.id?self.letterModel.id:@"",
                           @"page":@"1",
                           @"pageSize":@"6",
                           @"longitude":self.addressModelInfo.longitude ?self.addressModelInfo.longitude:@"",
                           @"latitude":self.addressModelInfo.latitude?self.addressModelInfo.latitude:@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:nil];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         [self.enjoyArr removeAllObjects];
                                                         NSMutableArray * dataArr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                             DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [dataArr addObject:model];
                                                             }
                                                         }
                                                         [self.enjoyArr  addObjectsFromArray: dataArr];
                                                         returnBlock();
                                                     }else {
                                                         failBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     failBlock();
                                                 }];
}

-(void)archivewRecommendProduceWithSuccessBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSDictionary *body = @{
                           @"page":@"1",
                           @"pageSize":@"5",
                           @"strRecommendOnly":@"true"
                           };
    [[HXNetManager shareManager] get:RecommendProductUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            [self.recomendArr removeAllObjects];
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



#pragma mark -- 获取推荐商家
-(void)archiveRecommend:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail{
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    LetterListModel * letterModel;
    letterModel = [VoListModel inquiryLetterModelWithName:city];
    NSDictionary *head = @{@"tradeCode" : @"0102",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"page" : @"1",
                           @"pageSize" : @"3",
                           @"cityId" : letterModel.id ? letterModel.id :@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"merchantList"]) {
                                                             
                                                             HXRecommendModel * model = [HXRecommendModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                             
                                                         }
                                                         returnBlock(arr);
                                                     }else {
                                                         fail();
                                                    }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     fail();
                                                     
                                                 }];
    
}
#pragma mark -- 获取推荐商家 特惠项目
-(void)archiveProject:(ReturnValueBlock)returnBlock fail:(FailureBlock)fail{
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    LetterListModel * letterModel;
    if (city) {
        letterModel = [VoListModel inquiryLetterModelWithName:city];
    }
    NSDictionary *head = @{@"tradeCode" : @"0104",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"page" : @"1",
                           @"pageSize" : @"10",
                           @"cityId" : letterModel.id ? letterModel.id :@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"productList"]) {
                                                             
                                                             HXProjectModel * model = [HXProjectModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 [arr addObject:model];
                                                             }
                                                         }
                                                         returnBlock(arr);
                                                     }else {
                                                         fail();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     fail();
                                                     
                                                 }];
    
}

-(void)creditActivationWithReturnBlock:(ReturnValueBlock)returnBlock {
    
     NSDictionary *head = @{@"tradeCode" : @"0230",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{
                           @"userUuid":userUuid
                           };
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         returnBlock();
                                                     }else {
                                                         [MBProgressHUD hideHUDForView:self.controller.view];
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     [MBProgressHUD hideHUDForView:self.controller.view];
                                                     
                                                 }];
    
}

-(void)archiveGetPacksBoolWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock{
    [[HXNetManager shareManager] get:OpenGiftUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.scoreBool = [[responseNewModel.body objectForKey:@"showFlag"] boolValue];
            returnBlock();
            
        }else {
            failBlock();
        }
        
    } failure:^(NSError *error) {
        failBlock();
    }];
    
    
    
}
-(void)openScoreWithWithReturnBlock:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock {
    [MBProgressHUD showMessage:nil toView:self.controller.view];
    [[HXNetManager shareManager] post:OpenNewGiftUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
           self.score = [[responseNewModel.body objectForKey:@"score"] stringValue];
            returnBlock();
        }else {
            failBlock();
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.controller.view];
        failBlock();
    }];
}

-(void)changeMemBer {
    NSDictionary * body = @{@"version":SHORT_VERSION,
                            @"device":@"iOS"
                            };
    [[HXNetManager shareManager] post:UpdateMemberUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
       
    } failure:^(NSError *error) {
       
    }];
    
}

-(void)archiveLoaclCompany:(NSMutableArray *)companyArr dispatch:(dispatch_queue_t)dispatch{
    dispatch_async(dispatch, ^{
        NSArray * dataArr =  [HXRecommendModel findAll];
        [companyArr addObjectsFromArray:dataArr];
    });
}
-(void)archiveLoaclProjectArr:(NSMutableArray *)projectArr dispatch:(dispatch_queue_t)dispatch{
    dispatch_async(dispatch, ^{
        NSArray * dataArr =  [HXProjectModel findAll];
        [projectArr addObjectsFromArray:dataArr];
    });
}

- (void)whetherSign {
    [[HXNetManager shareManager] get:GetMemberInfoUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            self.isCheckIn = [[responseNewModel.body objectForKey:@"isSignIn"] boolValue];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSMutableArray *)recomendArr {
    if (_recomendArr==nil) {
        _recomendArr = [[NSMutableArray alloc] init];
    }
    return _recomendArr;
}
-(NSMutableArray *)enjoyArr {
    if (_enjoyArr == nil) {
        _enjoyArr = [[NSMutableArray alloc] init];
    }
    return _enjoyArr;
}
@end
