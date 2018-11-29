//
//  UITableView+Refresh.m
//  FinanceProject
//
//  Created by PinE on 16/7/11.
//  Copyright © 2016年 品俄金融. All rights reserved.
//

#import "UITableView+Refresh.h"
#import "MJRefresh.h"

@implementation UITableView (Refresh)

- (void)addHeadRefreshWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
//    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
//    [header beginRefreshing];
    // 设置header
    self.mj_header = header;
    
    
    //self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

- (void)addFooterRefreshWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    /*
     MJChiBaoZiFooter2 *footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:target refreshingAction:action];
     // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
     //footer.triggerAutomaticallyRefreshPercent = 0.5;
     // 隐藏状态
     footer.stateLabel.hidden = YES;
     // 设置header
     self.footer = footer;
     */
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}


- (void)addheaderRefresh:(RefreshingBlock)refreshingBlock {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
//    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
//    [header beginRefreshing];
    // 设置header
    self.mj_header = header;
}

- (void)endheaderRefresh {
    [self.mj_header endRefreshing];
}

- (void)addFooterRefresh:(RefreshingBlock)refreshingBlock {
    /*
     MJChiBaoZiFooter2 *footer = [MJChiBaoZiFooter2 footerWithRefreshingBlock:refreshingBlock];
     // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
     //footer.triggerAutomaticallyRefreshPercent = 0.5;
     // 隐藏状态
     footer.stateLabel.hidden = YES;
     // 设置header
     self.footer = footer;
     */
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshingBlock];
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)endRefreshHeaderAndFooter {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
