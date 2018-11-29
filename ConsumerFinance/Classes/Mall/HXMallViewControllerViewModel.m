//
//  HXMallViewControllerViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/17.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMallViewControllerViewModel.h"
#import "HXMallModel.h"
#import "VoListModel.h"
#import "HXBannerModel.h"

@interface HXMallViewControllerViewModel()


@property (nonatomic, strong, readwrite) NSArray *banners;

@end

@implementation HXMallViewControllerViewModel

- (instancetype)init {
    if (self == [super init]) {
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        if (city) {
            self.locationCity = city;
        }
        [self updatLetterListModel:self.locationCity];
        self.index = 1;
        
        
        self.banners = @[@"big1",@"big2",@"big3"];
        
    }
    return self;
}

#pragma mark -- 获取商户分类
-(void)achieveAssortment:(void(^)())block {
    
    NSDictionary *head = @{@"tradeCode" : @"0101",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         [self.functionData removeAllObjects];
                                                         NSMutableArray * array = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"typeList"]) {
                                                             HXMallModel * model = [HXMallModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [array addObject:model];
                                                             }
                                                             //每次清空数据 更换城市
                                                         }
                                                         self.functionData = array;
                                                         block();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];

}
#pragma mark -- 猜你喜欢
//更换城市需要清空猜你喜欢数据 
-(void)archiveRecently:(ReturnValueBlock)returnBlock {
    
    NSDictionary *head = @{@"tradeCode" : @"0179",
                           @"tradeType" : @"appService"};
    
    NSDictionary *body = @{@"cityId":self.letterModel.id?self.letterModel.id:@"",
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.index],
                           @"pageSize":@"5",
                           @"longitude":self.addressModelInfo.longitude ?self.addressModelInfo.longitude:@"",
                           @"latitude":self.addressModelInfo.latitude?self.addressModelInfo.latitude:@"",
                           @"userUuid":userUuid
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     [MBProgressHUD hideHUDForView:nil];
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if (self.index ==1) {
                                                             
                                                             [self.enjoyArr removeAllObjects];
                                                         }
                                                         NSMutableArray * dataArr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"dtoList"]) {
                                                             DtoListModel * model = [DtoListModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [dataArr addObject:model];
                                                             }
                                                         }
                                                         [self.enjoyArr  addObjectsFromArray: dataArr];
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                 }];
}
-(void)archiveAd:(ReturnValueBlock)returnBlock {
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
    LetterListModel * letterModel;
    if (city) {
        letterModel = [VoListModel inquiryLetterModelWithName:city];
    }
    NSDictionary *head = @{@"tradeCode" : @"0106",
                           @"tradeType" : @"appService"};
    NSDictionary *body = @{@"cityId" : letterModel.id ? letterModel.id :@"",
                           @"locationType" : @"20"
                           };
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         NSMutableArray * arr = [[NSMutableArray alloc] init];
                                                         for (NSDictionary * dic in [object.body objectForKey:@"AdvertisementList"]) {
                                                             
                                                             HXBannerModel * model = [HXBannerModel mj_objectWithKeyValues:dic];
                                                             if (model) {
                                                                 
                                                                 [arr addObject:model];
                                                             }
                                                         }
                                                         if (arr.count!=0) {
                                                             
                                                             self.bannarArr = arr;
                                                         }
                                                         returnBlock();
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     
                                                     
                                                     
                                                 }];
    
}


#pragma mark --查询城市ID
-(void)updatLetterListModel:(NSString *)cityName {
    self.letterModel = [VoListModel inquiryLetterModelWithName:cityName];
}

-(void)archiveFunctionData {
    NSArray * arr = [HXMallModel findAll];
    NSMutableArray * mallArray = [[NSMutableArray alloc] init];
    for (HXMallModel *model in arr) {
        [mallArray addObject:model];
    }
    self.functionData = mallArray;
}

#pragma mark -- setter
-(NSMutableArray *)enjoyArr {
    if (_enjoyArr == nil) {
        _enjoyArr = [[NSMutableArray alloc] init];
    }
    return _enjoyArr;
}
@end
