//
//  Helper.m
//  huaxiafinance_user
//
//  Created by huaxiafinance on 16/2/18.
//  Copyright © 2016年 huaxiafinance. All rights reserved.
//

#import "Helper.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonHMAC.h>
#import "HXLoginViewController.h"

@implementation Helper

+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    CGFloat height = bounds.size.height+1;
    return height;
}

#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
    
}
//邮箱
+ (BOOL) justEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile
{
    if (mobile.length>11) {
        return NO;
    }
    //手机号以17,13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSString *phoneRegex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    //    虚拟运营商:(7[016-8]) 170/171/176/177/178
    //   166 号码段
    
    NSString *phoneRegex = @"^1(3[0-9]|4[0-9]|5[0-35-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) justCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) justUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) justPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) justNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard
{
        identityCard =[identityCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([identityCard length]!=18){
        return NO;
        }
    NSString *mmdd=@"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd=@"0229";
    NSString *year=@"(19|20)[0-9]{2}";
    NSString*leapYear=@"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString*yearMmdd=[NSString stringWithFormat:@"%@%@",year,mmdd];
    NSString*leapyearMmdd=[NSString stringWithFormat:@"%@%@",leapYear,leapMmdd];
    NSString*yyyyMmdd=[NSString stringWithFormat:@"((%@)|(%@)|(%@))",yearMmdd,leapyearMmdd,@"20000229"];
    NSString*area=@"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString*regex=[NSString stringWithFormat:@"%@%@%@",area,yyyyMmdd,@"[0-9]{3}[0-9Xx]"];

    NSPredicate*regexTest=[NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    if(![regexTest evaluateWithObject:identityCard]){
        return NO;
        }
    int summary=([identityCard substringWithRange:NSMakeRange(0,1)].intValue+[identityCard substringWithRange:NSMakeRange(10,1)].intValue)*7
    +([identityCard substringWithRange:NSMakeRange(1,1)].intValue+[identityCard substringWithRange:NSMakeRange(11,1)].intValue)*9
    +([identityCard substringWithRange:NSMakeRange(2,1)].intValue+[identityCard substringWithRange:NSMakeRange(12,1)].intValue)*10
    +([identityCard substringWithRange:NSMakeRange(3,1)].intValue+[identityCard substringWithRange:NSMakeRange(13,1)].intValue)*5
    +([identityCard substringWithRange:NSMakeRange(4,1)].intValue+[identityCard substringWithRange:NSMakeRange(14,1)].intValue)*8
    +([identityCard substringWithRange:NSMakeRange(5,1)].intValue+[identityCard substringWithRange:NSMakeRange(15,1)].intValue)*4
    +([identityCard substringWithRange:NSMakeRange(6,1)].intValue+[identityCard substringWithRange:NSMakeRange(16,1)].intValue)*2
    +[identityCard substringWithRange:NSMakeRange(7,1)].intValue*1+[identityCard substringWithRange:NSMakeRange(8,1)].intValue*6
    +[identityCard substringWithRange:NSMakeRange(9,1)].intValue*3;
    NSInteger remainder=summary%11;
    NSString*checkBit=@"";
    NSString*checkString=@"10X98765432";
    checkBit=[checkString substringWithRange:NSMakeRange(remainder,1)];//判断校验位
    return[checkBit isEqualToString:[[identityCard substringWithRange:NSMakeRange(17,1)]uppercaseString]];
    
}

//在数字中间添加逗号
+ (NSString *)localizedStringFromNumber:(NSInteger)num{
    
    NSInteger count = 0;
    long long int a = num;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld",(long)num]];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
    
    
}
//判断是否为纯数字
+ (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为纯字母
+(BOOL)isPureCharCharacters:(NSString *)string{
    // 编写正则表达式：只能是英文
    NSString *regex = @"^[a-zA-Z]*$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 对字符串进行判断
    if ([predicate evaluateWithObject:string]) {
        return YES;
    } else {
        return NO;
    }
}
/**
 *  hmac_sha256加密
 *
 */
+ (NSString *)hmac_sha256:(NSString *)text{
    
    
    NSString *key = @"[B@6d00a15d";
    
    
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA256_DIGEST_LENGTH];
    
    
    NSString *resultstr = [GTMBase64 stringByEncodingData:HMAC];
    
    
    return resultstr;
    
    
}
//字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//byte数组转NSData
+ (NSData *)ByteArrayToData:(NSArray *)byteArray {
    unsigned c = byteArray.count;
    uint8_t *bytes = malloc(sizeof(*bytes) * c);
    
    unsigned i;
    for (i = 0; i < c; i++) {
        NSString *str = [byteArray objectAtIndex:i];
        int byte = [str intValue];
        bytes[i] = (uint8_t)byte;
    }
    return [NSData dataWithBytes:bytes length:c];
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/**
 *  含有特殊字符
 */
+(BOOL)hasSpecialChar:(NSString *)str{
    
    // 编写正则表达式：只能是英文
    
    NSString *regex = @"[^%&',;=?$\x22]+";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 对字符串进行判断
    if ([predicate evaluateWithObject:str]) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)hasOnlyNumAndChar:(NSString *)str {
    NSString *passWordRegex = @"^[a-zA-Z0-9]*$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:str];
}

+(NSString*)addComma:(NSString*)string{
    //删除字符串中的空格 逗号
    NSArray *strArrayA = [string componentsSeparatedByString:@"."];
    NSString *str = strArrayA[0];
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"，" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger length = [str length];
    NSMutableArray *strArray = [NSMutableArray array];
    for(int i = 0;i<length;i++)
    {
        NSRange range = {i, 1};
        NSString *strA = [str substringWithRange:range];
        [strArray addObject:strA];
    }
    NSInteger num = length/3;//对三求商2
    NSInteger temp = length%3;//对三求余1
    switch (temp) {
        case 0:
            for (NSInteger i = 1; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*(i-1)+3)];
                
            }
            break;
        case 1:
            for (NSInteger i = 0; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*i+temp)];
                
            }
            break;
        case 2:
            for (NSInteger i = 0; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*i+temp)];
                
            }
            break;
        default:
            break;
    }
    NSString *textMoney = @"";
    if(strArray.count>0)
    {
        for (int i = 0; i<strArray.count; i++) {
            NSString *text = [NSString stringWithFormat:@"%@",strArray[i]];
            textMoney = [textMoney stringByAppendingString:text];
        }
    }
    for (int i = 1; i < strArrayA.count; i++) {
        NSString *comd = strArrayA[i];
        NSString *text = @"";
        if (comd.length == 1) {
            text = [NSString stringWithFormat:@".%@0",comd];
        }else {
            text = [NSString stringWithFormat:@".%@",comd];
       
        }
        
         textMoney = [textMoney stringByAppendingString:text];
    }
    return textMoney;

}

+ (NSString *)sumWithString:(NSString *)string{
    
    NSArray *count = [string componentsSeparatedByString:@","];
    CGFloat sum = 0.0;
    for (NSString *str in count) {
        CGFloat num = [str floatValue];
        sum = sum + num;
    }
    NSString *returnStr = [NSString stringWithFormat:@"%.2f",sum];
    return returnStr;
    
    
    
    
}

+ (NSString *)replaceString:(NSString *) string{
    
    NSString *returnStr = @"";
    
    for (int i=0; i<string.length; i++) {
        
        NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
        
        const char *ch = [subStr UTF8String];
        
        if (*ch>='0'&&*ch<='9') {
            
            returnStr = [returnStr stringByAppendingString:subStr];
            
        }
        
    }
    return returnStr;
}

+ (BOOL)isChinese{
    
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
+ (void)createImageWithColor:(UIColor *)color button:(UIButton *)button style:(UIControlState)state
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *imageNormal = [theImage resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [button setBackgroundImage:imageNormal forState:state];
    
}
+(void)adjustLabel:(UILabel *)label str:(NSString *)str font:(NSInteger)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@起",str]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(1, str.length)];
    label.attributedText = attributedString;
}
+(void)justLabel:(UILabel *)label title:(NSString *)title font:(NSInteger)font {
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:@"¥"].location + 1;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"起"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:ComonBackColor range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}

+(void)justColorLabel:(UILabel *)label firTitle:(NSString *)title secTitle:(NSString *)secTitle font:(NSInteger)font {
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:title].location;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:secTitle].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc-firstLoc+1);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:ComonBackColor range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}

+(NSString *)returnBankName:(NSString*) idCard{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
//        _resultLabel.text = @"卡号不合法";
        return @"";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
//        _resultLabel.text = @"plist文件中不存在请自行添加对应卡种";
        return @"";
    }
    return @"";
    
}

+(HXSuportBankModel *)belogCardNumber:(NSString *)card bankArr:(NSMutableArray *)bankArr{
  
    NSString * cardName = [Helper returnBankName:card];
    for (HXSuportBankModel * model in bankArr) {
        if ([cardName containsString:[Helper exchangeBankeName:model.bankName]]) {
            return model;
        }
    }

    return nil;
    
}

+(NSString *)exchangeBankeName:(NSString *)bankName {
    
    if ([bankName isEqualToString:@"中国工商银行"]) {
        return @"工商银行";
    }else if ([bankName isEqualToString:@"中国建设银行"]) {
        return @"建设银行";
    }else if ([bankName isEqualToString:@"中国农业银行"]) {
        return @"农业银行";
    }else if ([bankName isEqualToString:@"中国光大银行"]) {
        return @"光大银行";
    }else if ([bankName isEqualToString:@"中国民生银行"]) {
        return @"民生银行";
    }else {
        return bankName;
    }
    

}
+(NSString *)photoUrl:(NSString *)url width:(NSInteger)width height:(NSInteger)height{
    NSString * str = [[NSString stringWithFormat:@"%@?imageView2/2/w/%ld/h/%ld/q/75|imageslim",url,(long)width,(long)height]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return str;
}

+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,177,180,189
//     22         */
//    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
     NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if([regextestPHS evaluateWithObject:cellNum] == YES)
    {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)authBool:(NSString *)auth {
    if (!auth) {
        return NO;
    }
    if ([auth isEqualToString:@"1"] ||[auth isEqualToString:@"2"]) {
        return YES;
    }
    return NO;
}

+(void)changeTextWithFont:(NSInteger )font title:(NSString *)title changeTextArr:(NSArray *)changeTextArr label:(UILabel *)label color:(UIColor *)color{
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:title];
    for (NSString * str in changeTextArr) {
        NSRange range1=[[hintString string]rangeOfString:str];
        [hintString addAttribute:NSForegroundColorAttributeName  value:color range:range1];
        UIFont *semiboldFont =[UIFont fontWithName:@"PingFangSC-Semibold" size:font];
        if (semiboldFont) {
            [hintString addAttribute:NSFontAttributeName  value:[UIFont fontWithName:@"PingFangSC-Semibold" size:font] range:range1];
        } else {
            [hintString addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:font] range:range1];
        }
    }
    label.attributedText=hintString;
}

+(BOOL)justNumerWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string numberLength:(NSInteger)length{
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    NSString * NumbersWithDot =@"1234567890.";
    NSString * NumbersWithoutDot =@"1234567890";
    if (![string isEqualToString:@""]) {
        
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        
        // 判断字符串中是否有小数点，并且小数点不在第一位
        
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        
        if (dotLocation == NSNotFound && range.location != 0) {
            
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            
            /*
             
             [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去
             
             在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             
             */
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot] invertedSet];
            
            if (range.location >= length) {
                NSLog(@"单笔金额不能超过亿位");
                
                if ([string isEqualToString:@"."] && range.location == length) {
                    return YES;
                }
                
                return NO;
                
            }
            
        }else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithoutDot] invertedSet];
        }
        
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            NSLog(@"只能输入数字和小数点");
            return NO;
        }
        
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            NSLog(@"小数点后最多两位");
            return NO;
        }
        
        if (textField.text.length > 8) {
            return NO;
        }
        
    }
    return YES;
}

+(void)textField:(UITextField *)textField length:(NSInteger)length
{
   
      NSInteger Max_Num_TextView = length;
    bool isChinese;//判断是否是中文
    
    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }

    //如果语言是汉语(拼音)
    if (isChinese)
    {
        
        //取到高亮部分范围
        UITextRange *selectedRange = [textField markedTextRange];
        
        //取到高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        //如果取不到高亮部分,代表没有拼音
        if (!position){
            
            //当期超过最大限制时
            if (textField.text.length > Max_Num_TextView) {
                
                //对超出部分进行裁剪
                textField.text = [textField.text substringToIndex:Max_Num_TextView];
            }
        }else{
            //表示还有高亮部分，暂不处理
        }
        
    }else{
        //如果语言不是汉语,直接计算
        if (textField.text.length > Max_Num_TextView) {
            
            textField.text = [textField.text substringToIndex:Max_Num_TextView];
        }
    }
}

- (NSString *)disable_emoji:(NSString *)text
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0,
                                                                                   [text length])
                                                          withTemplate:@""];
    return modifiedString;
}




+(void)textFieldDidChange:(UITextField *)textField length:(NSInteger)length{
    bool isChinese;//判断是否是中文
    
    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    
    //要求输入最多40位字符
    NSString *str = [[textField text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            NSLog(@"输入的是汉字");
            if ( str.length>=length+1) {
                NSString *strNew = [NSString stringWithString:str];
                [textField setText:[strNew substringToIndex:length]];
            }
        }else{
            NSLog(@"英文还没有转化为汉字");
        }
    }else{
        if ([str length]>=length+1) {
            NSString *strNew = [NSString stringWithString:str];
            [textField setText:[strNew substringToIndex:length]];
        }
    }
}


+(NSString *)reviseString:(id)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

+(void)pushLogin:(UIViewController *)controller {
    
    HXLoginViewController * loan = [[HXLoginViewController alloc] init];
    loan.hidesBottomBarWhenPushed = YES;
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;            //改变视图控制器出现的方式
    transition.subtype = kCATransitionFromTop;     //出现的位置
    
    [controller.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [controller.navigationController pushViewController:loan animated:NO];
    
}


//时间戳转成"yyyy-MM-dd HH:mm:ss"格式
+ (NSString *)dateWithTimeStampAll:(NSInteger)time {
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//时间戳转成"yyyy.MM.dd"格式
+ (NSString *)dateWithTimeStampDate:(NSInteger)time {
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒
    return timeStr;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    
    [label sizeToFit];
}

@end
