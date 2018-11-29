//
//  HXSearchHotTableViewCellViewModel.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/27.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXCommand.h"

@interface HXSearchHotTableViewCellViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray *hotKeys;
@property (nonatomic, assign) CGFloat cellHeight;

@end
