//
//  HXChoosePackageTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+HXCommandCategory.h"
#import "HXPackageModel.h"

@interface HXChoosePackageTableViewCell : UITableViewCell

@property (nonatomic, strong) HXPackageModel *model;
@property (nonatomic, strong) HXCommand *hx_command;

@end
