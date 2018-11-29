//
//  BeautyClinicModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BeautyClinicModel.h"

@implementation BeautyClinicModel
-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"dtoList" : @"DtoList",
             };
    
}

#pragma mark -- 判断文本高度
+(void)dealTitleHeightStateWithModl:(BeautyClinicModel *)model{
    CGFloat titleHeight = [Helper heightOfString:model.title font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-130];
    if (titleHeight > 32) {
        model.cellHeight = 105;
        return;
    }
    model.cellHeight = 90;
}
@end
