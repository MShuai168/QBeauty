//
//  ProfileManager.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/16.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ProfileManager.h"

@implementation ProfileManager


#pragma mark - 婚姻状况

+ (NSDictionary *)maritalStatusDictionary {
    
    NSDictionary *dict = @{@"10" :	@"已婚",
                           @"20" :	@"未婚",
                           @"21" :	@"离异",
                           @"25" :	@"丧偶",
                           @"30" :	@"再婚"};
    return dict;
}

+ (NSString *)getMaritalStatusWithCode:(NSString *)code {
    
    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self maritalStatusDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getMaritalStatusWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self maritalStatusDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}

#pragma mark - 在读学历

+ (NSDictionary *)educationDictionary {
    
    NSDictionary *dict = @{@"1" : @"大专以下",
                           @"2" : @"大专",
                           @"3" : @"本科",
                           @"4" : @"研究生及以上"};
    return dict;
}

+ (NSString *)getEducationStringWithCode:(NSString *)code {
    
    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self educationDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getEducationCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self educationDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}

#pragma mark - 公司类型

+ (NSDictionary *)companyTypeDictionary {
    
    NSDictionary *dict = @{@"00" : @"政府机关",
                           @"10" : @"事业单位",
                           @"20" : @"国企",
                           @"30" : @"外企",
                           @"40" : @"合资",
                           @"50" : @"民营",
                           @"60" : @"私企",
                           @"70" : @"个体"};
    return dict;
}

+ (NSString *)getCompanyTypeStringWithCode:(NSString *)code {

    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self companyTypeDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getCompanyTypeCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self companyTypeDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}


#pragma mark - 房产信息

+ (NSDictionary *)estateDictionary {
    
    NSDictionary *dict = @{@"1" : @"自有房产,无按揭",
                           @"2" : @"自有房产,有按揭",
                           @"3" : @"亲属房产",
                           @"4" : @"其它"};
    return dict;
}

+ (NSString *)getEstateStringWithCode:(NSString *)code {

    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self estateDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getEstateCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self estateDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}


#pragma mark - 每月生活费\月兼职收入

+ (NSDictionary *)livingExpensesDictionary {
    
    NSDictionary *dict = @{@"1" : @"500以下",
                           @"2" : @"500-1000",
                           @"3" : @"1000-1500",
                           @"4" : @"1500-2000",
                           @"5" : @"2000以上"};
    return dict;
}

+ (NSString *)getLivingExpensesStringWithCode:(NSString *)code {

    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self livingExpensesDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getLivingExpensesCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self livingExpensesDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}


#pragma mark - 订单状态

+ (NSDictionary *)orderStatusDictionary {
    
    NSDictionary *dict = @{@"0020HX1000" : @"审核",
                           @"0021HX1000" : @"审核任务池",
                           @"0022HX1000" : @"挂起",
                           @"0031HX1000" : @"审核拒绝",
                           @"0040HX1000" : @"补件",
                           @"0050HX1000" : @"客户确认",
                           @"0070HX1000" : @"待放款",
                           @"0080HX1000" : @"已放款",
                           @"3000HX1000" : @"审核取消",
                           @"3001HX1000" : @"客户取消"};
    return dict;
}

+ (NSString *)getOrderStatusStringWithCode:(NSString *)code {

    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self orderStatusDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getOrderStatusCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self orderStatusDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}


#pragma mark - 联系人类型

+ (NSDictionary *)contactTypeDictionary {
    
    NSDictionary *dict = @{@"01" : @"父亲",
                           @"02" : @"母亲",
                           @"03" : @"配偶",
                           @"04" : @"子女",
                           @"05" : @"同学",
                           @"06" : @"同事",
                           @"07" : @"朋友"};
    return dict;
}

+ (NSString *)getContactTypeStringWithCode:(NSString *)code {
    
    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self contactTypeDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getContactTypeCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self contactTypeDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}


#pragma mark - 兼职状态

+ (NSDictionary *)partTimeDictionary {
    
    NSDictionary *dict = @{@"1" : @"是",
                           @"2" : @"否"};
    return dict;
}

+ (NSString *)getPartTimeStringWithCode:(NSString *)code {
    
    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self partTimeDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}

+ (NSString *)getPartTimeCodeWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self partTimeDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}
#pragma mark -- 资料认证状态
+(NSDictionary *)getAuthenticatingStateDictionary {
    
    NSDictionary *dict = @{@"0" : @"未填写",
                           @"1" : @"已填写",
                           @"2" : @"已认证",
                           @"3" : @"认证失败",
                           @"4" : @"认证失效"};
    return dict;
}
+(NSString *)getAuthenticatingStateWithCode:(NSString *)code {
    if ([NSString isBlankString:code]) return @"";
    
    NSString *string = [self getAuthenticatingStateDictionary][code];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
    
}
+ (NSString *)getAuthenticatingStateWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self getAuthenticatingStateDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *v = dict[key];
        if ([v isEqualToString:value]) {
            return key;
            break;
        }
    }
    return @"";
}

#pragma mark -- 获取快递名称
+(NSDictionary *)getExpressNameDictionary {
    
    NSDictionary *dict = @{@"1" : @"圆通",
                           @"2" : @"申通",
                           @"3" : @"韵达",
                           @"4" : @"中通",
                           @"5" : @"EMS",
                           @"6" : @"顺丰",
                           @"7" : @"天天",
                           @"8" : @"宅急送",
                           @"9" : @"汇通",
                           @"10" : @"德邦",
                           @"11":@""
                           };
    return dict;
}
+ (NSString *)getExpressNameWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self getExpressNameDictionary];
    
    if ([NSString isBlankString:value]) return @"";
    
    NSString *string = dict[value];
    
    if ([NSString isBlankString:string]) return @"";

    return string;
}


#pragma mark -- 获取快递状态
+(NSDictionary *)getExpressStateDictionary {
    
    NSDictionary *dict = @{@"1" : @"已发货",
                           @"2" : @"已签收",
                           @"3" : @"",
                           };
    return dict;
}
+ (NSString *)getExpressStateWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self getExpressStateDictionary];
    
    if ([NSString isBlankString:value]) return @"";
    
    NSString *string = dict[value];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}
#pragma mark -- 获取购买记录状态
+(NSDictionary *)getBuyRecordStateDictionary {
    
    NSDictionary *dict = @{@"0" : @"待支付",
                           @"1" : @"已支付",
                           @"2" : @"已取消",
                           };
    return dict;
}

+ (NSString *)getBuyRecordStateWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self getBuyRecordStateDictionary];
    
    if ([NSString isBlankString:value]) return @"";
    
    NSString *string = dict[value];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}


#pragma mark -- 获取提现记录状态
+(NSDictionary *)getWithdrawStateDictionary {
    NSDictionary *dict = @{@"1" : @"已提交",
                           @"2" : @"处理中",
                           @"3" : @"提现成功",
                           @"4" : @"提现失败"
                           };
    return dict;
    
}

+ (NSString *)getWithdrawStateWithString:(NSString *)value {
    
    if ([NSString isBlankString:value]) return @"";
    
    NSDictionary *dict = [self getWithdrawStateDictionary];
    
    if ([NSString isBlankString:value]) return @"";
    
    NSString *string = dict[value];
    
    if ([NSString isBlankString:string]) return @"";
    
    return string;
}


@end
