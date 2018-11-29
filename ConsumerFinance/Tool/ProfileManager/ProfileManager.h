//
//  ProfileManager.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/16.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

/*

用户类型:
01	企业主
02	上班族
03	学生
04	自由职业者
------------------------------
 
婚姻状况:
10	已婚
20	未婚
21	离异
25	丧偶
30	再婚
------------------------------
 
在读学历:
1	大专以下
2	大专
3	本科
4	研究生及以上
------------------------------
 
公司类型:
00	政府机关
10	事业单位
20	国企
30	外企
40	合资
50	民营
60	私企
70	个体
------------------------------
 
房产信息:
1	自有房产，无按揭
2	自有房产，有按揭
3	亲属房产
4	其它
------------------------------

每月生活费\月兼职收入:
1	500以下
2	500-1000
3	1000-1500
4	1500-2000
5	2000以上
------------------------------
 
是否兼职:
1	是
2	否
------------------------------
 
订单状态:
0020HX1000	审核
0021HX1000	审核任务池
0022HX1000	挂起
0031HX1000	审核拒绝
0040HX1000	补件
0050HX1000	客户确认
0070HX1000	待放款
0080HX1000	已放款
3000HX1000	审核取消
3001HX1000	客户取消
------------------------------
 
联系人类型:
01	父亲
02	母亲
03	配偶
04	子女
05	同学
06	同事
07	朋友
*/

@interface ProfileManager : NSObject

#pragma mark - 婚姻状况
/*!
 * @brief 根据Code返回婚姻状况
 * @param code 婚姻状况itemNO
 * @return 婚姻状况字符串
 */
+ (NSString *)getMaritalStatusWithCode:(NSString *)code;
/*!
 * @brief 根据婚姻状况返回code值
 * @param value 婚姻状况
 * @return 婚姻状况code
 */
+ (NSString *)getMaritalStatusWithString:(NSString *)value;


#pragma mark - 在读学历
/*!
 * @brief 根据Code返回学历信息
 * @param code 学历信息itemNO
 * @return 学历信息字符串
 */
+ (NSString *)getEducationStringWithCode:(NSString *)code;
/*!
 * @brief 根据学历信息返回code值
 * @param value 学历信息
 * @return 学历信息code
 */
+ (NSString *)getEducationCodeWithString:(NSString *)value;

#pragma mark - 公司类型
/*!
 * @brief 根据Code返回公司类型
 * @param code 公司类型itemNO
 * @return 公司类型字符串
 */
+ (NSString *)getCompanyTypeStringWithCode:(NSString *)code;
/*!
 * @brief 根据公司类型返回code值
 * @param value 公司类型
 * @return 公司类型code
 */
+ (NSString *)getCompanyTypeCodeWithString:(NSString *)value;


#pragma mark - 房产信息
/*!
 * @brief 根据Code返回房产信息
 * @param code 房产信息itemNO
 * @return 房产信息字符串
 */
+ (NSString *)getEstateStringWithCode:(NSString *)code;
/*!
 * @brief 根据房产信息返回code值
 * @param value 房产信息
 * @return 房产信息code
 */
+ (NSString *)getEstateCodeWithString:(NSString *)value;


#pragma mark - 每月生活费\月兼职收入
/*!
 * @brief 根据Code返回每月生活费
 * @param code 每月生活费itemNO
 * @return 每月生活费字符串
 */
+ (NSString *)getLivingExpensesStringWithCode:(NSString *)code;
/*!
 * @brief 根据每月生活费返回code值
 * @param value 每月生活费
 * @return 每月生活费code
 */
+ (NSString *)getLivingExpensesCodeWithString:(NSString *)value;


#pragma mark - 订单状态
/*!
 * @brief 根据Code返回订单状态
 * @param code 订单状态itemNO
 * @return 订单状态字符串
 */
+ (NSString *)getOrderStatusStringWithCode:(NSString *)code;
/*!
 * @brief 根据订单状态返回code值
 * @param value 订单状态
 * @return 订单状态code
 */
+ (NSString *)getOrderStatusCodeWithString:(NSString *)value;


#pragma mark - 联系人类型
/*!
 * @brief 根据Code返回联系人类型
 * @param code 联系人类型itemNO
 * @return 联系人类型字符串
 */
+ (NSString *)getContactTypeStringWithCode:(NSString *)code;
/*!
 * @brief 根据联系人类型返回code值
 * @param value 联系人类型
 * @return 联系人类型code
 */
+ (NSString *)getContactTypeCodeWithString:(NSString *)value;


#pragma mark - 兼职状态
/*!
 * @brief 根据Code返回兼职状态
 * @param code 兼职状态itemNO
 * @return 兼职状态字符串
 */
+ (NSString *)getPartTimeStringWithCode:(NSString *)code;
/*!
 * @brief 根据兼职状态返回code值
 * @param value 兼职状态
 * @return 兼职状态code
 */
+ (NSString *)getPartTimeCodeWithString:(NSString *)value;

/**
 根据资料认证状态码 获取对应的文字

 @param code code值
 @return 对应的文本
 */
+(NSString *)getAuthenticatingStateWithCode:(NSString *)code;


/**
 获取快递名称

 @param value 快递对应的code
 @return 快递名称
 */
+ (NSString *)getExpressNameWithString:(NSString *)value;


/**
 获取快递状态

 @param value 对应的code
 @return 快递状态
 */
+ (NSString *)getExpressStateWithString:(NSString *)value;


/**
 获取购买记录状态

 @param value 对应的code
 @return 购买记录状态
 */
+ (NSString *)getBuyRecordStateWithString:(NSString *)value;
/**
 获取提现记录状态
 
 @param value 对应的code
 @return 购买记录状态
 */
+ (NSString *)getWithdrawStateWithString:(NSString *)value;
@end
