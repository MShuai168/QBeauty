//
//  HXPartnerRecordViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPartnerRecordViewModel.h"
#import "HXBuyRecordModel.h"
@implementation HXPartnerRecordViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        self.buyRecordIndex = 1;
        self.incomeIndex = 1;
        self.withdrawIndex = 1;
    }
    return self;
}
-(void)archiveRecordInformationWithType:(NSString *)type returnBlock:(ReturnValueBlock)returnBlock failBlock:(FailureBlock)failBlock {
    NSString * page;
    if ([type intValue]==1) {
        page = [NSString stringWithFormat:@"%ld",self.buyRecordIndex];
    }else if ([type intValue]==2) {
       page = [NSString stringWithFormat:@"%ld",self.incomeIndex];
    }else {
       page = [NSString stringWithFormat:@"%ld",self.withdrawIndex];
    }
    NSDictionary * dic = @{@"type":type,
                           @"page":page,
                           @"rows":@"10"
                           };
    
    [[HXNetManager shareManager] get:PartnerRecord parameters:dic sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
            if ([type isEqualToString:@"1"]) {
                if (self.buyRecordIndex==1) {
                    [self.buyRecordArr removeAllObjects];
                }
                for (NSDictionary * dic in [responseNewModel.body objectForKey:@"list"]) {
                    HXBuyRecordModel * model = [HXBuyRecordModel mj_objectWithKeyValues:dic];
                    if (model) {
                        [self.buyRecordArr addObject:model];
                    }
                }
            }else if ([type isEqualToString:@"2"]) {
                if (self.incomeIndex==1) {
                    [self.incomeArr removeAllObjects];
                }
                for (NSDictionary * dic in [responseNewModel.body objectForKey:@"list"]) {
                    HXBuyRecordModel * model = [HXBuyRecordModel mj_objectWithKeyValues:dic];
                    if (model) {
                        [self.incomeArr addObject:model];
                    }
                }
                
            }else {
                if (self.withdrawIndex == 1) {
                    [self.withdrawArr removeAllObjects];
                }
                for (NSDictionary * dic in [responseNewModel.body objectForKey:@"list"]) {
                    HXBuyRecordModel * model = [HXBuyRecordModel mj_objectWithKeyValues:dic];
                    if (model) {
                        [self.withdrawArr addObject:model];
                    }
                }
                
            }
            
            
            if (returnBlock) {
                returnBlock();
            }
        }
        
    } failure:^(NSError *error) {
        if (failBlock) {
            failBlock();
        }
    }];
}


-(void)showItemView:(UIView *)view  type:(NSInteger)type kindType:(NSString *)kindType{
    if ([kindType intValue]==1) {
        if (self.buyStateView) {
            [self.buyStateView removeFromSuperview];
        }
        self.buyStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.buyRecordIndex = 1;
            [self click:kindType];
        }];
    }else if ([kindType intValue]==2) {
        if (self.incomeStateView) {
            [self.incomeStateView removeFromSuperview];
        }
        self.incomeStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.incomeIndex = 1;
            [self click:kindType];
        }];
        
        
    }else  {
        if (self.withdrawStateView) {
            [self.withdrawStateView removeFromSuperview];
        }
        self.withdrawStateView = [self creatStatesView:view showType:type offset:0  showInformation:^{
            self.withdrawIndex = 1;
            [self click:kindType];
        }];
        
        
    }
}

-(void)click:(NSString *)type {
    if ([self.controller respondsToSelector:NSSelectorFromString(@"request:")]){
        SEL selector = NSSelectorFromString(@"request:");
        IMP imp = [self.controller methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self.controller, selector,type);
        self.openHdBool = YES;
        [MBProgressHUD showMessage:nil toView:self.controller.view];
    }
}
-(NSMutableArray *)buyRecordArr {
    if (_buyRecordArr==nil) {
        _buyRecordArr = [[NSMutableArray alloc] init];
    }
    return _buyRecordArr;
}
-(NSMutableArray *)incomeArr {
    if (_incomeArr == nil) {
        _incomeArr = [[NSMutableArray alloc] init];
    }
    return _incomeArr;
}
-(NSMutableArray *)withdrawArr {
    if (_withdrawArr==nil) {
        _withdrawArr = [[NSMutableArray alloc] init];
    }
    return _withdrawArr;
}
@end
