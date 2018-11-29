//
//  HXOrderInfo.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/15.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^returnController)(UIViewController *controller);

@interface HXOrderInfo : NSObject

@property (nonatomic, strong) NSString *id; // 我们系统的订单id
//@property (nonatomic, strong) NSString *userUuid;
@property (nonatomic, strong) NSString *resultCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *orderNo; //订单编号
@property (nonatomic, strong) NSString *stagesMoney;//分期金额
@property (nonatomic, strong) NSString *orderStatus;//订单状态
@property (nonatomic, strong) NSString *loanStatus;//放款状态
@property (nonatomic, strong) NSString *firstPayment;//首付金额
@property (nonatomic, strong) NSString *periods;//期数
@property (nonatomic, strong) NSString *onceInterest;//一次性利息
@property (nonatomic, strong) NSString *borrowRate;//借款利率
@property (nonatomic, strong) NSString *discountPeriods;//贴息期数
@property (nonatomic, strong) NSString *productName;//商品名称
@property (nonatomic, strong) NSString *productPrice;//商品价格
@property (nonatomic, strong) NSString *productTypeId;//商品分类id
@property (nonatomic, strong) NSString *salesmanName;//销售员名字
@property (nonatomic, strong) NSString *salesmanCellphone;//销售员手机号
@property (nonatomic, strong) NSString *companyId;//商户id
@property (nonatomic, strong) NSString *merchantName; // 商户名称
@property (nonatomic, strong) NSString *gpsCode;//gps经纬度
@property (nonatomic, strong) NSString *approvalAmount;//审批金额
@property (nonatomic, strong) NSString *remark;//备注
@property (nonatomic, strong) NSString *productCode;//产品CODE
@property (nonatomic, strong) NSString *riskPee;//风险保证金
@property (nonatomic, strong) NSString *stageType;//分期类型
@property (nonatomic, strong) NSString *financeCost;//年资金成本
@property (nonatomic, strong) NSString *approveAt;//审批时间
@property (nonatomic, strong) NSString *createdTime; // 创建时间
@property (nonatomic, strong) NSString *upTime; // 更新时间
@property (nonatomic, strong) NSString *isNew;//新旧区分(默认旧数据 1：新 0：旧)
@property (nonatomic, strong) NSString *productId;//项目id
@property (nonatomic, strong) NSString *distinguish;//订单区分（10通用20汽车30租房40蜜月）
@property (nonatomic, strong) NSString *idCard;//身份证
@property (nonatomic, strong) NSString *name;//姓名
@property (nonatomic, strong) NSString *phone;//联系方式
@property (nonatomic, strong) NSString *reservationId;//预约单号
@property (nonatomic,strong) NSString * serviceCharge;
@property (nonatomic, strong) NSString *yfqStatus;//一分期内部状态（10商家提交订单，15消费者确认订单有误，20消费者确认，30商家确认，                40选择贷款产品，50提交个人认证，60签订合同,70取消订单）

// 租房
@property (nonatomic, strong) NSString *communityName; //小区名称
@property (nonatomic, strong) NSString *detailAddress; //房屋详细地址
@property (nonatomic, strong) NSString *rent; //月租金

// 蜜月
@property (nonatomic, strong) NSString *estimatedTime; //预计出发时间
@property (nonatomic, strong) NSString *departure; //出发地
@property (nonatomic, strong) NSString *destination; //目的地
@property (nonatomic, strong) NSString *tourismType;// 旅游形式(1自助2跟团)

// 汽车
@property (nonatomic, strong) NSString *buyType; //购买形式(1:以租代购，2直购)
@property (nonatomic, strong) NSString *netPrice; //净车价
@property (nonatomic, strong) NSString *licenseFee; //上牌费
@property (nonatomic, strong) NSString *insurance;// 保险费
@property (nonatomic, strong) NSString *purchaseTax;// 购置税

@property (nonatomic, strong) NSString * approveTime;
@property (nonatomic,strong) NSString * isYimei;

- (void)orderStatusHandleWithBlock:(returnController)returnController with:(orderType)orderType;

- (NSString *)paddingBuyType:(NSString *)buyType;
- (NSString *)paddingTourismType:(NSString *)tourismType;

@end
