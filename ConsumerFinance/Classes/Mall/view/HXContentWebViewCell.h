//
//  HXContentWebViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/4.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol SourceCell;
@interface HXContentWebViewCell : BaseTableViewCell
@property (nonatomic,strong)NSString * htmlStr;
@property (nonatomic,strong)NSString * secondHtmlStr;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,weak)id<SourceCell>delegate;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIWebView *secondWebView;
@property (nonatomic,assign) BOOL buttonSelected;
@property (nonatomic,assign) NSInteger secondRefreshCount;
@property (nonatomic,assign) NSInteger cellRefreshCount;
@end
@protocol SourceCell <NSObject>

-(void)webViewDidFinishLoad:(UIWebView *)webView;

@end
