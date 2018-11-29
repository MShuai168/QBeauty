//
//  VoListModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "VoListModel.h"
@interface VoListModel()
@property (nonatomic,strong)NSArray * dataArr;
@end
@implementation VoListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"letterList" : @"LetterListModel",
             };
}

+(NSMutableArray *)changeHotList{
    return [self changeHotList:[VoListModel findAll]];
}

+(NSMutableArray *)changeHotList:(NSArray *)list {
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (VoListModel *model in list) {
        NSMutableArray * nameArr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        for (LetterListModel * letModel  in model.letterList) {
            [nameArr addObject:letModel.cityName];
        }
        [dic setValue:nameArr forKey:model.firstLetter];
        [arr addObject:dic];
    }
    return arr;
}

+(NSMutableArray *)changeScreenList {
    return [self changeScreenList:[VoListModel findAll]];
}

+(NSMutableArray *)changeScreenList:(NSArray *)list {
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (VoListModel *model in list) {
        [arr addObject:model.firstLetter];
    }
    return arr;
}

+(LetterListModel *)inquiryLetterModelWithName:(NSString *)cityName {
    for (VoListModel *model in [VoListModel findAll]) {
        for (LetterListModel * letModel  in model.letterList) {
            if (cityName.length!=0) {
                if ([letModel.cityName rangeOfString:cityName].location !=NSNotFound) {
                    return letModel;
                }
            }
        }
    }
    
    return nil;
}

@end
