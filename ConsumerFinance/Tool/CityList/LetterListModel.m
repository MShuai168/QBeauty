//
//  LetterListModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "LetterListModel.h"

@implementation LetterListModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_cityName forKey:@"cityName"];
    [aCoder encodeObject:_distList forKey:@"distList"];
    [aCoder encodeObject:_id forKey:@"id"];
    [aCoder encodeObject:_jianpin forKey:@"jianpin"];
    [aCoder encodeObject:_quanpin forKey:@"quanpin"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _cityName = [aDecoder decodeObjectForKey:@"cityName"];
        _distList = [aDecoder decodeObjectForKey:@"name"];
        _id = [aDecoder decodeObjectForKey:@"id"];
        _jianpin = [aDecoder decodeObjectForKey:@"jianpin"];
        _quanpin = [aDecoder decodeObjectForKey:@"quanpin"];
    }
    return self;
}
@end
