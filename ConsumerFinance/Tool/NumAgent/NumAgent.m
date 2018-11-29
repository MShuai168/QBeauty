#import "NumAgent.h"

@implementation NumAgent

+ (NSString *)roundPlain:(NSString *)num ifKeep:(BOOL)ifKeep
{
    // 先对数字进行四舍五入操作
    NSDecimalNumberHandler *round = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                           scale:2
                                                                                raiseOnExactness:NO
                                                                                 raiseOnOverflow:NO
                                                                                raiseOnUnderflow:NO
                                                                             raiseOnDivideByZero:YES];
    NSDecimalNumber *inputNumber = [NSDecimalNumber decimalNumberWithString:num];
    NSDecimalNumber *outputNumber = [inputNumber decimalNumberByRoundingAccordingToBehavior:round];
    // 格式化:对数字是否强制保留两位(强制保留两位的话小数点后不足两位补0)进行处理
    NSString *outputStr = [NSString stringWithFormat:@"%@",outputNumber];
    if (ifKeep) {
        NSRange range = [outputStr rangeOfString:@"."];
        if (range.length) {
            // 截取小数部分
            NSString *subStr = [outputStr substringFromIndex:range.location + 1];
            // 如果小数部分的位数小于2，只可能有一种情况:就是小数点后只有一位，所以需要补0。
            if (subStr.length < 2) {
                outputStr = [NSString stringWithFormat:@"%@0",outputStr];
            }
        }
        else {
            // outputStr所代表的数字是一个证书这里要拼上.00
            outputStr = [NSString stringWithFormat:@"%@.00",outputStr];
        }
    }
    
    return outputStr;
}

+ (NSString *)roundDown:(NSString *)num ifKeep:(BOOL)ifKeep
{
    num = [Helper reviseString:num];
    // 先对数字进行截位操作
    NSDecimalNumberHandler *round = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                           scale:2
                                                                                raiseOnExactness:NO
                                                                                 raiseOnOverflow:NO
                                                                                raiseOnUnderflow:NO
                                                                             raiseOnDivideByZero:YES];
    NSDecimalNumber *inputNumber = [NSDecimalNumber decimalNumberWithString:num];
    NSDecimalNumber *outputNumber = [inputNumber decimalNumberByRoundingAccordingToBehavior:round];
    // 格式化:对数字是否强制保留两位(强制保留两位的话小数点后不足两位补0)进行处理
    NSString *outputStr = [NSString stringWithFormat:@"%@",outputNumber];
    if (ifKeep) {
        NSRange range = [outputStr rangeOfString:@"."];
        if (range.length) {
            // 截取小数部分
            NSString *subStr = [outputStr substringFromIndex:range.location + 1];
            // 如果小数部分的位数小于2，只可能有一种情况:就是小数点后只有一位，所以需要补0。
            if (subStr.length < 2) {
                outputStr = [NSString stringWithFormat:@"%@0",outputStr];
            }
        }
        else {
            // outputStr所代表的数字是一个证书这里要拼上.00
            outputStr = [NSString stringWithFormat:@"%@.00",outputStr];
        }
    }
    
    return outputStr;
}

+ (NSString *)countNumAndChangeformat:(NSString *)num
{
    long long number = [num longLongValue];
    NSString *last = @"";
    NSString *xiaoshu = @"";//小数部分的字符串
    NSString *b = [NSString stringWithFormat:@"%lld",number];
    NSString *shuchu;
    if (b.length == num.length) {
        last = num;
    }
    else {
        last = [num substringWithRange:NSMakeRange(0, b.length)];
        xiaoshu = [num substringWithRange:NSMakeRange(b.length, (num.length-b.length))];
    }
    
    NSString *eastNum = @"";
    NSString *help;
    
    if (num.length <= 3) {
        eastNum = last;
    }
    else {
        for (int i = (int)last.length - 1; i >= 0; i --) {
            help = [last substringWithRange:NSMakeRange(i, 1)];
            if ((last.length - i) % 3 == 0 && i > 0) {
                help = [NSString stringWithFormat:@",%@",[last substringWithRange:NSMakeRange(i, 1)]];
            }
            eastNum = [NSString stringWithFormat:@"%@%@",help,eastNum];
            
        }
    }
    shuchu = [NSString stringWithFormat:@"%@%@",eastNum,xiaoshu];
    
    return shuchu;
}

+ (BOOL)isApproximateInteger:(double)num
{
    long long a = (long long)num * 1000000;
    long long b = (long long)(num * 1000000);
    if (a == b) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSString *)fomateNum:(NSString *)num {
    NSString *result = num;
    if ([num hasSuffix:@".00"]) {
        NSRange range = [num rangeOfString:@".00"];
        result = [num substringToIndex:range.location];
    }
    return result;
}

@end
