//
//  NSMutableAttributedString+Category.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Category)
- (void) appendString:(NSString *)string withAttributes:(NSDictionary *)attributes;
- (void) addLine:(NSUInteger)lines;
@end
