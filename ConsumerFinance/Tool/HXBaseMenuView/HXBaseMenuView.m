//
//  HXBaseMenuView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseMenuView.h"
#import "HXMonoidalView.h"
#import "HXMultitermView.h"
@implementation HXBaseMenuView
-(id)initWithItem:(HXItem *)item
{
    self = [super init];
    if (self) {
        self.item = item;
        self.selectedArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectedArray = [NSMutableArray array];
    }
    return self;
}
+ (HXBaseMenuView *)getSubPopupView:(HXItem *)item {
    HXBaseMenuView *view;
    switch (item.type) {
        case HXPopupViewSingleSelection:
            view = [[HXMonoidalView alloc] initWithItem:item];
            break;
        case HXPopupViewMultilSeMultiSelection:
            view = [[HXMultitermView alloc] initWithItem:item];
            break;
        default:
            break;
    }
    
    return view;
}
-(void)creatUI {
    
}
-(void)dismiss {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
