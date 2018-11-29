//
//  HXCommand.h
//
//  Created by 刘勇强 on 17/3/29.
//  Copyright (c) 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXCommand : NSObject

- (instancetype)initWithBlock:(void (^)(id input))block;

- (void)execute:(id)input;

@end
