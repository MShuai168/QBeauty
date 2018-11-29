//
//  HXSearchHotTableViewCellViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/27.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchHotTableViewCellViewModel.h"


@interface HXSearchHotTableViewCellViewModel()

@property (nonatomic, strong, readwrite) NSArray *hotKeys;

@end

@implementation HXSearchHotTableViewCellViewModel

- (instancetype)init {
    if (self == [super init]) {
        _hotKeys = @[];
    }
    
    return self;
}

@end
