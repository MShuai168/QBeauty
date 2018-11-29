//
//  NetRequestClass.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "NetRequestClass.h"
//修改个人信息
NSString * const ChangeInformation = @"partnerRecord/updatePurchaseDetails";
//获取个人修改信息
NSString * const AchiveInformation = @"partnerDetails/getPartnerDetails";
//获取个人信息
NSString * const PersonInformation = @"partnerDetails/getPartnerInfo";
//获取合伙人银行卡信息
NSString * const PartnerBankInformation = @"partnerDetails/getPartnerBankDetails";
//合伙人银行卡信息修改
NSString * const PartnerSubmitBankInformation = @"partnerDetails/updatePartnerInfo";
//合伙人申请提现
NSString * const PartnerApplyMoney = @"withdrawals/getWithdrawals";
//合伙人提现
NSString * const PartnerWithdrawMoney = @"withdrawals/applyWithdrawals";
//合伙人记录
NSString * const PartnerRecord = @"partnerRecord/getRecord";
//合伙人订单结果
NSString * const PartnerResult = @"partnerRecord/getPurchaseDetails";
//取消合伙人套餐
NSString * const PartnerOrderCancel = @"partnerRecord/updateOrder";
//合伙人提现失败
NSString * const PartnerOrderFail = @"partnerRecord/getGiveDetails";
//判断合伙人跳转页面
NSString * const PartnerRouter = @"prePartner/getRouter";
//合伙人我的团队
NSString * const PartnerMyteam = @"partnerInfo/queryPartnerInfoByParentId";
//是否打开新人礼盒
NSString * const OpenGiftUrl = @"gift/getShowGiftFlag";
//打开新人礼盒
NSString * const OpenNewGiftUrl = @"gift/getNewMemberGift";
//更新会员等级
NSString * const UpdateMemberUrl = @"scoreMemberOrder/addMember";
//获取推荐产品
NSString * const RecommendProductUrl = @"scoreCommon/queryRecommendProduct";
//查询购物车
NSString * const QueryShoppingCartUrl = @"scoreOrder/queryShoppingCart";
//新增购物车产品数量
NSString * const AddShoppingCart = @"scoreOrder/addShoppingCart";
//修改购物车
NSString * const ChangeShopCart = @"scoreOrder/modifyShoppingCart";
//下订单
NSString * const PlaceOrderUrl = @"scoreOrder/placeOrder";
//查询支付结果
NSString * const QueryPayResultUrl = @"scoreOrder/queryPayResult";
//支付
NSString * const PayUrlParamUrl = @"scoreOrder/payUrlParam";
//查询商品是否下架
NSString * const ProductIsOnshelfUrl = @"scoreOrder/productIsOnshelf";
//删除商品
NSString * const DeleteShoppingCart = @"scoreOrder/deleteShoppingCart";
//获取会员信息
NSString * const GetMemberUrl = @"member/getMember";
//获取个人等级积分信息
NSString * const GetMemberInfoUrl = @"member/getMemberInfo";
//查询签到信息
NSString * const QuerySignInfo = @"scoreSign/querySignInfo";
//获取兑换列表
NSString * const GetExchangeListUrl = @"exchange/getExchangeList";
//修改订单状态
NSString * const UpdateExchangeStatusUrl = @"exchange/updateExchangeStatus";
//兑换详情
NSString * const GetExchangeDetail = @"exchange/getExchangeDetail";
//签到
NSString * const SignUrl = @"scoreSign/sign";
//个人信息
NSString * const MyCenter = @"scoreCommon/myCenter";
//我的积分
NSString * const MyMemberInfo = @"scoreMemberOrder/getMemberInfo";
//上传头像
NSString * const UploadHeaderUrl = @"user/uploadHeader";
//获取头像
NSString * const GetHeaderUrl = @"user/getHeader";
//获取推荐链接
NSString * const GetCodeUrl = @"member/getCode";
//赚趣贝详情
NSString * const GetTaskListUrl= @"earnScore/getTaskList";
//注册协议
NSString * const AgreementUrl = @"agreement/list";
//获取首页广告 浏览图片
NSString * const GetBannerUrl = @"scoreCommon/getBanner";
@implementation NetRequestClass

@end
