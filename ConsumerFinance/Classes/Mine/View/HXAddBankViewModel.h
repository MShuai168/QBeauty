//
//  HXAddBankViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "HXSuportBankModel.h"
@interface HXAddBankViewModel : HXBaseViewModel
@property (nonatomic,strong) NSString * iphoneNumber; //手机号
@property (nonatomic,strong) NSString * cardNumber; //银行卡号
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * citiId;
@property (nonatomic,strong) NSString * provinceId;
@property (nonatomic,strong) NSString * messageCode;//短信验证码
@property (nonatomic,strong) NSString * nameStr;
@property (nonatomic,strong) NSString * idCardStr;

@property (nonatomic,strong)HXSuportBankModel * suportModel;

@property (nonatomic,strong)NSString * flowOrderID;
@property (nonatomic,strong)NSMutableArray * supportBankArr;
@property (nonatomic,strong)NSString * orderNo;


/**
 获取短信验证码

 @param returnBlock 回调
 */
-(void)archiveMessageWithReturnBlock:(ReturnValueBlock)returnBlock;

-(void)submitBankInformationWithReturnBlock:(ReturnValueBlock)returnBlock;

-(void)archiveBankListWithReturnBlock:(ReturnValueBlock)returnBlock;
-(void)archiveSuportBankInformation;
@end
