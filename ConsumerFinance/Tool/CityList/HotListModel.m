//
//  HotListModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HotListModel.h"

@implementation HotListModel
+(NSMutableArray *)changeHotListData:(NSArray *)dataArr {
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (HotListModel *model in dataArr) {
        [arr addObject:model.cityName];
    }
    return arr;
}
@end
