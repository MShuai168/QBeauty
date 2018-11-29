//
//  WKWeakScriptMessageDelegate.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/5/2.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WKScriptMessageHandler.h>

@interface WKWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
