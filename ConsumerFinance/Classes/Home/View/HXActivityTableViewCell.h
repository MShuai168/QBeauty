//
//  HXActivityTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXActivityModel.h"

@interface HXActivityTableViewCell : UITableViewCell

@property (nonatomic, strong) HXActivityModel *model;

@property (nonatomic, assign) float height;

@end
