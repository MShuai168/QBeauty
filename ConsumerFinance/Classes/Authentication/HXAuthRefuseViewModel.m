////
////  HXAuthRefuseViewModel.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/5/25.
////  Copyright © 2017年 ConsumerFinance. All rights reserved.
////
//
//#import "HXAuthRefuseViewModel.h"
//
//@implementation HXAuthRefuseViewModel
//#pragma mark -- 替换文本状态文本
//-(void)replaceTitleWithTileBlock:(void(^)(NSString * title ,NSString * description,float titleHeight))block {
//    NSString * stateStr;
//    switch (self.states) {
//        case OrderStatuesCancel:
//        {
//            stateStr = @"订单已取消！";
//            if (self.supplyDescription.length!=0) {
//                
//                self.supplyDescription = [NSString stringWithFormat:@"取消理由:%@",self.supplyDescription];
//            }
//        }
//            break;
//        case OrderStatuesRefuse:
//        {
//            stateStr = @"审核拒绝！";
//            if (self.supplyDescription.length!=0) {
//                
//                self.supplyDescription = [NSString stringWithFormat:@"原因:%@",self.supplyDescription];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    if (stateStr.length!=0) {
//        
//        if (block) {
//            CGFloat height =  [Helper heightOfString:self.supplyDescription font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-60];
//            if (height<20) {
//                
//                block(stateStr,self.supplyDescription,0);
//            }else {
//                block(stateStr,self.supplyDescription,height);
//            }
//        }
//    }
//    
//}
//-(void)archiveTypeFormotName {
//    switch (self.orderType) {
//        case orderTypeCommon:
//        {
//            self.nameArr = @[@[@"姓名",@"手机号",@"身份证"],@[@"商户名称",@"项目名称"],@[@"商品金额",@"首付金额",@"申请金额"]];
//        }
//            break;
//        case orderTypeCarBuy:
//        {
//            self.nameArr = @[@[@"姓名",@"手机号",@"身份证"],@[@"4S店",@"汽车型号",@"购车方式"],@[@"净车价",@"上牌费",@"保险费",@"购置税",@"首付金额",@"申请分期金额"]];
//        }
//            break;
//        case orderTypeHoneymoon:
//        {
//            self.nameArr = @[@[@"姓名",@"手机号",@"身份证"],@[@"旅游形式",@"预计出发时间",@"出发地",@"目的地"],@[@"商品金额",@"首付金额",@"申请金额"]];
//        }
//            break;
//        case orderTypeTenancy:
//        {
//            self.nameArr = @[@[@"姓名",@"手机号",@"身份证"],@[@"商户名称",@"小区名称",@"房屋详细地址",@"月租金"],@[@"商品金额",@"首付金额",@"申请金额"]];
//        }
//            break;
//        case orderTypeCarRent:
//        {
//            
//            self.nameArr = @[@[@"姓名",@"手机号",@"身份证"],@[@"4S店",@"汽车型号",@"购车形式",@"备注"],@[@"商品金额",@"首付金额",@"申请金额"]];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    [self changeInformation];
//}
//-(void)changeInformation {
//    NSMutableArray * dataArr = [[NSMutableArray alloc] init];
//    NSArray * secArr;
//    NSArray * thirdArr;
//    //@[@"订单",@"创建时间",@"取消时间"]
//    NSArray * commArr =   @[self.orderInfo.orderNo?:@"",self.orderInfo.createdTime?:@"",self.orderInfo.upTime?:@""];
//    //@[@"姓名",@"联系方式",@"身份证号"]
//    NSArray * nameArr = @[self.orderInfo.name?self.orderInfo.name:@"",self.orderInfo.phone?self.orderInfo.phone:@"",self.orderInfo.idCard?self.orderInfo.idCard:@""];
//    
//    //@[@"合同金额",@"首付金额",@"申请金额"]
//    thirdArr = @[self.orderInfo.productPrice?[NSString stringWithFormat:@"¥%@",self.orderInfo.productPrice]:@"",self.orderInfo.firstPayment?[NSString stringWithFormat:@"¥%@",self.orderInfo.firstPayment]:@"",self.orderInfo.stagesMoney?[NSString stringWithFormat:@"¥%@",self.orderInfo.stagesMoney]:@""];
//    
//    [dataArr addObject:commArr];
//    [dataArr addObject:nameArr];
//    
//    switch (self.orderType) {
//        case orderTypeCommon:
//        {
//        //商户名称 项目名称
//           secArr = @[self.orderInfo.merchantName?self.orderInfo.merchantName:@"",self.orderInfo.productName?self.orderInfo.productName:@""];
//        }
//            break;
//        case orderTypeTenancy:
//        {
//            //商户名称 小区名称 房屋地址 月租金
//            secArr = @[self.orderInfo.merchantName?self.orderInfo.merchantName:@"",self.orderInfo.communityName?self.orderInfo.communityName:@"",self.orderInfo.detailAddress?self.orderInfo.detailAddress:@"",self.orderInfo.rent?self.orderInfo.rent:@""];
//           
//        }
//            break;
//        case orderTypeHoneymoon:
//        {
//            //@[@"旅游形式",@"预计出发时间",@"出发地",@"目的地"]
//            
//            secArr = @[[self.orderInfo paddingTourismType:self.orderInfo.tourismType],self.orderInfo.estimatedTime?self.orderInfo.estimatedTime:@"",self.orderInfo.departure?self.orderInfo.departure:@"",self.orderInfo.destination?self.orderInfo.destination:@""];
//        }
//            break;
//        case orderTypeCarBuy:
//        {
//            //@[@"4S店",@"汽车型号",@"购车方式"]
//            
//            secArr = @[self.orderInfo.merchantName?self.orderInfo.merchantName:@"",self.orderInfo.productName?self.orderInfo.productName:@"",[self.orderInfo paddingBuyType:self.orderInfo.buyType]];
//            //@[@"净车价",@"上牌费",@"保险费",@"购置税",@"首付金额",@"申请分期金额"]
//            thirdArr = @[[NSString stringAddChineseMark:self.orderInfo.netPrice]?:@"",[NSString stringAddChineseMark:self.orderInfo.licenseFee]?:@"",[NSString stringAddChineseMark:self.orderInfo.insurance]?:@"",[NSString stringAddChineseMark:self.orderInfo.purchaseTax]?:@"",[NSString stringAddChineseMark:self.orderInfo.firstPayment]?:@"",[NSString stringAddChineseMark:self.orderInfo.stagesMoney]?:@""];
//            
//        }
//            break;
//        case orderTypeCarRent:
//        {
//           //@[@"4S店",@"汽车型号",@"购车方式",@"备注"]
//            secArr = @[self.orderInfo.merchantName?self.orderInfo.merchantName:@"",self.orderInfo.productName?self.orderInfo.productName:@"",[self.orderInfo paddingBuyType:self.orderInfo.buyType],self.orderInfo.remark?self.orderInfo.remark:@""];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    [dataArr addObject:secArr?secArr:@[]];
//    [dataArr addObject:thirdArr?thirdArr:@[]];
//    self.informationArr = dataArr;
//}
//
//@end
