//
//  WKWeakScriptMessageDelegate.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/5/2.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "WKWeakScriptMessageDelegate.h"

@implementation WKWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}



@end
