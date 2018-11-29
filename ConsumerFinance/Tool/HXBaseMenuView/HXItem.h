//
//  HXItem.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, HXPopupViewSelectedType) {     //是否支持单选或者多选
    HXPopupViewSingleSelection,                            //单选
    HXPopupViewMultilSeMultiSelection,                    //多选
};
@interface HXItem : NSObject
@property (nonatomic,strong) NSMutableArray <HXItem*> *dateArr; //存储数据信息
@property (nonatomic,strong) NSMutableArray * selectedArray; //记录选中下标
@property (nonatomic, strong) NSString *title;
@property (nonatomic,assign) HXPopupViewSelectedType type;
@property (nonatomic,assign) BOOL selected;

+(instancetype)itemWithItemType:(HXPopupViewSelectedType)type titleName:(NSString *)title;
- (void)addNode:(HXItem *)node;
@end
