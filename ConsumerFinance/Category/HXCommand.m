//
//  HXCommand.m
//
//  Created by 刘勇强 on 17/3/29.
//  Copyright (c) 2017年 All rights reserved.
//

#import "HXCommand.h"

@interface HXCommand ()

@property (nonatomic, copy) void (^commandBlock)(id input);
@end

@implementation HXCommand

- (instancetype)initWithBlock:(void (^)(id input))block
{
    if (self = [super init]) {
        _commandBlock = [block copy];
    }
    return self;
}

- (void)execute:(id)input
{
    if (_commandBlock) {
        _commandBlock(input);
    }
}


@end
