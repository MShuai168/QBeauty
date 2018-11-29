//
//  HXSelectedPath.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/10.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXSelectedPath : NSObject
@property (nonatomic, assign) NSInteger firstPath;          //
@property (nonatomic, assign) NSInteger secondPath;         //default is -1.
+ (instancetype)pathWithFirstPath:(NSInteger)firstPath secondPath:(NSInteger)firstPath;
+ (instancetype)pathWithFirstPath:(NSInteger)firstPath;
@end
