//
//  HXSelectTableView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/12.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSelectTableView : UIView
+ (instancetype)shareSheet;
- (void)hx_selectTableWithSelectArray:(NSArray *)array  title:(NSString *)title select:(void (^)())selectBlock;
@end
