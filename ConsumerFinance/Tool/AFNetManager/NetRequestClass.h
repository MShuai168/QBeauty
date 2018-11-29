//
//  NetRequestClass.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const ChangeInformation;//修改个人信息
extern NSString * const AchiveInformation;//获取修改个人信息
extern NSString * const PersonInformation;//获取个人信息
extern NSString * const PartnerBankInformation;//获取银行卡信息
extern NSString * const PartnerSubmitBankInformation;//提交合伙人银行卡信息
extern NSString * const PartnerApplyMoney;//合伙人申请提现
extern NSString * const PartnerWithdrawMoney;//合伙人提现
extern NSString * const PartnerRecord;//合伙人记录
extern NSString * const PartnerResult;//合伙人结果
extern NSString * const PartnerOrderCancel;//取消合伙人套餐
extern NSString * const PartnerOrderFail;//合伙人提现失败
extern NSString * const PartnerRouter;//判断合伙人跳转页面
extern NSString * const PartnerMyteam;//合伙人我的团队
extern NSString * const OpenGiftUrl; //是否打开新人礼盒
extern NSString * const OpenNewGiftUrl; //打开新人礼盒
extern NSString * const UpdateMemberUrl ;//更新会员等级
extern NSString * const RecommendProductUrl;//获取推荐产品
extern NSString * const QueryShoppingCartUrl;//查询购物车
extern NSString * const AddShoppingCart;//新增购物车产品数量
extern NSString * const ChangeShopCart;//修改购物车
extern NSString * const PlaceOrderUrl;//下订单
extern NSString * const QueryPayResultUrl;//查询支付结果
extern NSString * const PayUrlParamUrl;//支付
extern NSString * const ProductIsOnshelfUrl; //查询商品是否下架
extern NSString * const DeleteShoppingCart; //删除商品
extern NSString * const GetMemberUrl;//获取会员信息
extern NSString * const GetMemberInfoUrl;//获取个人等级积分信息
extern NSString * const GetExchangeListUrl;//获取兑换列表
extern NSString * const UpdateExchangeStatusUrl;//修改订单状态
extern NSString * const GetExchangeDetail;//兑换详情
extern NSString * const SignUrl;//签到
extern NSString * const MyCenter;//个人信息
extern NSString * const MyMemberInfo;//我的积分
extern NSString * const UploadHeaderUrl;//上传头像
extern NSString * const QuerySignInfo;//查询签到信息
extern NSString * const GetHeaderUrl;//获取头像
extern NSString * const GetCodeUrl;//获取推荐链接
extern NSString * const GetTaskListUrl;//赚趣贝详情
extern NSString * const AgreementUrl; //注册协议
extern NSString * const GetBannerUrl;//获取首页广告 浏览图片
@interface NetRequestClass : NSObject

@end
