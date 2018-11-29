//
//  HXSearchHotTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/27.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXSearchHotTableViewCellViewModel.h"

@interface HXSearchHotTableViewCell : UITableViewCell
@property (nonatomic, strong) HXCommand *hx_command;
@property (nonatomic, strong) HXSearchHotTableViewCellViewModel *viewModel ;
- (instancetype)initWithHotName:(NSMutableArray *)nameArr;
@end
