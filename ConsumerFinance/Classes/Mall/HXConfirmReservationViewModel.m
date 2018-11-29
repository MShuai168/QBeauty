//
//  HXConfirmReservationViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/24.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXConfirmReservationViewModel.h"
#import "CurrentLocation.h"
#import "VoListModel.h"
@interface HXConfirmReservationViewModel()
@property (nonatomic,strong)LetterListModel * letterModel;
@end
@implementation HXConfirmReservationViewModel
-(id)initWithController:(UIViewController *)controller {
    self = [super initWithController:controller];
    if (self) {
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCity];
        LetterListModel * letterModel;
        letterModel = [VoListModel inquiryLetterModelWithName:city];
        self.letterModel = letterModel;
    }
    return self;
    
}
-(void)submitCertificationWithName:(NSString *)name phone:(NSString *)phone remark:(NSString *)remark returnBlock:(ReturnValueBlock)returnBlock{
    [[CurrentLocation sharedManager] gpsCityWithLocationAddress:^(AddressModelInfo *addressModel) {
        LetterListModel *letterModel = [VoListModel inquiryLetterModelWithName:addressModel.city];
        NSDictionary *head = @{@"tradeCode" : @"0137",
                               @"tradeType" : @"appService"};
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPhone];
        NSDictionary *body = @{@"userPhone" : phone.length!=0?phone:@"",
                               @"locCity" :letterModel.id?letterModel.id:@"",
                               @"name" :name?name:@"",
                               @"proId" :self.preModel.id?self.preModel.id:@"",
                               @"merId" :self.preModel.merId?self.preModel.merId:@"",
                               @"remarks" :remark?remark:@"",
                               @"phone":phone?phone:@""
                               };
        [MBProgressHUD showMessage:nil toView:self.controller.view];
        [[AFNetManager manager] postRequestWithHeadParameter:head
                                               bodyParameter:body
                                                     success:^(ResponseModel *object) {
                                                         
                                                         [MBProgressHUD hideHUDForView:self.controller.view];
                                                         if (IsEqualToSuccess(object.head.responseCode)) {
                                                             
                                                             
                                                             returnBlock();
                                                         }
                                                         
                                                     } fail:^(ErrorModel *error) {
                                                         
                                                         [MBProgressHUD hideHUDForView:self.controller.view];
                                                         
                                                     }];

        
        return;
    }];
}
@end
