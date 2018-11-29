//
//  HXPackageDetailTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPackageDetailModel.h"

@interface HXPackageDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) HXPackageDetailModel *model;
@property (nonatomic, assign) float height;

@end
