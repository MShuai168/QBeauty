//
//  NSDate+Category.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/5.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSString *)timestampToTime:(NSString *)timestamp {
    return nil;
}

+ (NSString *)timeToTimestamp:(NSString *)time {
    return nil;
}


+ (NSString *)getNowTime:(NSDate *)date{
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    dateFormate.dateFormat = @"YYYYMMdd";
    [dateFormate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormate setTimeZone:[NSTimeZone timeZoneWithName:@"GTM+8"]];
    NSString *dateStr = [dateFormate stringFromDate:date];
    return dateStr;
}

@end
