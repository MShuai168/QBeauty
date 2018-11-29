//
//  HXBaseMenuView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXItem.h"
@interface HXBaseMenuView : UIView
@property (nonatomic,strong) HXItem * item;
@property (nonatomic,strong) void (^selectItem)(); //菜单选项响应
@property (nonatomic, strong) NSMutableArray *selectedArray;//保存选择下标
-(id)initWithItem:(HXItem *)item;
+ (HXBaseMenuView *)getSubPopupView:(HXItem *)item;

/**
 创建UI界面
 */
-(void)creatUI;

-(void)dismiss;
@end
