//
//  HXPayViewControllerViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, payStatus) {
    payStatusNull,
    payStatusSucess,
    payStatusFail,
    payStatusProcess
};

@interface HXPayViewControllerViewModel : NSObject

@property (nonatomic, assign) payStatus payStatus;

@end
