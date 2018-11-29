//
//  NSDate+Category.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/5.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *  时间戳转时间
 *
 *  @param timestamp 时间戳
 *
 *  @return 转换后的时间字符串
 */
+ (NSString *)timestampToTime:(NSString *)timestamp;
/**
 *  时间转时间戳
 *
 *  @param timestamp 时间字符串
 *
 *  @return 转换后的时间戳字符串
 */
+ (NSString *)timeToTimestamp:(NSString *)time;
/**
 *  获取时间字符串
 *
 *  @param date 时间
 *
 *  @return 时间字符串
 */

+ (NSString *)getNowTime:(NSDate *)date;

@end
