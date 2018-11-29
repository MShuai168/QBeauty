//
//  HXBaseViewModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"

@implementation HXBaseViewModel
-(id)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    
    
    return self;
}
#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}
-(HXStateView *)creatStatesView:(UIView *)view showType:(NSInteger)type offset:(NSInteger)offset showInformation:(void (^)())showInformation {
    
    HXStateView * stateView = [[HXStateView alloc] initWithalertShow:type backView:view offset:offset];
    stateView.submitBlock = ^{
        showInformation();
    };
    return stateView;
    
    
}

@end
