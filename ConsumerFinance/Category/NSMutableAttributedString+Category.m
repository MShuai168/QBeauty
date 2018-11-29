//
//  NSMutableAttributedString+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.


#import "NSMutableAttributedString+Category.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (Category)

- (void) appendString:(NSString *)string withAttributes:(NSDictionary *)attributes {
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string
                                                                 attributes:attributes]];
}

- (void) addLine:(NSUInteger)lines {
    NSString* line = [NSString string];
    for (NSInteger i = 0; i < lines; i++) {
        line = [line stringByAppendingString:@"\n"];
    }
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:line
                                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8.0f]}]];
}

@end


