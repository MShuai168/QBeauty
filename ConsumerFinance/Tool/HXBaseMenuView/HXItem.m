//
//  HXItem.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXItem.h"

@implementation HXItem
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dateArr = [[NSMutableArray alloc] init];
    }
    return self;
}
+(instancetype)itemWithItemType:(HXPopupViewSelectedType)type titleName:(NSString *)title {
    HXItem *item = [[[self class] alloc] init];
    item.type = type;
    item.title = title;
    return item;
}

- (void)addNode:(HXItem *)node {
    node.selected = NO;
    [self.dateArr addObject:node];
}

@end
