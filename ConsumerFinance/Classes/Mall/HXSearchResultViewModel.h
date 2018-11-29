//
//  HXSearchResultViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/29.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetterListModel.h"
#import "CurrentLocation.h"
@interface HXSearchResultViewModel : NSObject
@property (nonatomic,strong) UIViewController * controller;
@property (nonatomic, strong) NSString *searchContent;// 搜索的内容
@property (nonatomic, strong) LetterListModel * letterModel;//城市ID
@property (nonatomic,assign) NSInteger index; //商户下标
@property (nonatomic,assign) NSInteger proindex;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * itemArr;
@property (nonatomic,strong) HXStateView * stateView;
@property (nonatomic,strong) HXStateView * itmStateView;
@property (nonatomic,strong) AddressModelInfo * addressModel;
/**
 获取商户搜索列表

 @param returnBlock 回调
 */
-(void)archiveMerchantdetails:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;


-(void)archiveItemdetails:(ReturnValueBlock)returnBlock fail:(FailureBlock)failBlock;

-(void)conserveKeyWord:(NSString *)name;
@end
