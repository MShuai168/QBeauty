/*
 对数字的格式化处理都集中到这里
 */
#import <Foundation/Foundation.h>

@interface NumAgent : NSObject

/**
 数字四舍五入格式化

 @param num 数字
 @param ifKeep 是否固定保留两位（位数不足补0）
 @return 四舍五入格式化后的字符串
 */
+ (NSString *)roundPlain:(NSString *)num ifKeep:(BOOL)ifKeep;


/**
 数字截位格式化

 @param num 数字
 @param ifKeep 是否固定保留两位（位数不足补0）
 @return 截尾格式化后的字符串
 */
+ (NSString *)roundDown:(NSString *)num ifKeep:(BOOL)ifKeep;


/**
 数字千分位格式化

 @param num 数字
 @return 千分位格式化后的字符串
 */
+ (NSString *)countNumAndChangeformat:(NSString *)num;


/**
 判断一个小数是否约等于整数(*1000000做比较)

 @param num 数字
 @return (BOOL)
 */
+ (BOOL)isApproximateInteger:(double)num;

/**
 如果小数点后是.00，直接去掉.00

 @param num 传入的参数。前提：此参数如果有小数点，必须是两位，才可以满足此方法
 @return 返回format后的值
 */
+ (NSString *)fomateNum:(NSString *)num;




@end
