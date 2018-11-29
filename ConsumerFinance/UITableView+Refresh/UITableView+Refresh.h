//
//  UITableView+Refresh.h
//  FinanceProject
//
//  Created by PinE on 16/7/11.
//  Copyright © 2016年 品俄金融. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshingBlock)(void);

@interface UITableView (Refresh)

- (void)addHeadRefreshWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (void)addFooterRefreshWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)addheaderRefresh:(RefreshingBlock)refreshingBlock;
- (void)endheaderRefresh;
- (void)addFooterRefresh:(RefreshingBlock)refreshingBlock;
- (void)endFooterRefresh;

- (void)endRefreshHeaderAndFooter;

@end
