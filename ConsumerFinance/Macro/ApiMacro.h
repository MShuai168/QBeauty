//
//  ApiMacro.h
//  QianXiang
//
//  Created by 侯荡荡 on 16/3/22.
//  Copyright © 2016年 Hou. All rights reserved.
//

#ifndef ApiMacro_h
#define ApiMacro_h


#define user_id                                    [AppManager manager].userInfo.userId
#define userUuid                                   (user_id ? user_id : @"")


#define  isTestingEnvironment          true      //Debug状态下切换测试环境、本地环境


#ifdef DEBUG ////Debug状态下的测试API
////测试环境
#ifdef isTestingEnvironment
#define kNewAPIHost                                 @"https://uat.qbeauty.com.cn/beautylady_score/"
#define kScoreUrl                                   @"https://uat.qbeauty.com.cn/score/#/"  //"趣淘"首页
#define kExchangeUrl                                @"https://uat.qbeauty.com.cn/qrcode/exchange"  //礼品兑换
#else ////本地环境
#define kNewAPIHost                                 @"http://192.168.1.197:8080/beautylady_score/"
#define kScoreUrl                                   @"http://192.168.1.197:8080/score/#/"
#define kExchangeUrl                                @"http://114.55.141.139:10083/exchange"
#endif
#define  isRelease          false
#else  ////Release状态下的线上API
////生产环境
#define kNewAPIHost                                 @"https://api.qbeauty.com.cn/beautylady_score/"
#define kScoreUrl                                   @"https://h.qbeauty.com.cn/score/#/"  //"趣淘"首页
#define kExchangeUrl                                @"https://h.qbeauty.com.cn/qrcode/exchange"  //礼品兑换
#define  isRelease          true
#endif


#define  bucketNameXXX               (isRelease ? "qb-online" : "qb-test")   //阿里云上传图片设置的bucketName

#endif /* ApiMacro_h */

