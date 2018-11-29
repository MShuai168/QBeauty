//
//  HXSelectedPath.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/10.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSelectedPath.h"

@implementation HXSelectedPath
- (instancetype)init {
    self = [super init];
    if (self) {
        self.secondPath = -1;
    }
    return self;
}
+ (instancetype)pathWithFirstPath:(NSInteger)firstPath secondPath:(NSInteger)secondPath {
    HXSelectedPath *path = [HXSelectedPath pathWithFirstPath:firstPath];
    path.secondPath = secondPath;
    return path;
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath {
    HXSelectedPath *path = [[[self class] alloc] init];
    path.firstPath = firstPath;
    return path;
}
@end
