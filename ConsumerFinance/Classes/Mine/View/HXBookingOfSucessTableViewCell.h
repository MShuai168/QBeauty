//
//  HXBookingOfSucessTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/7/5.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXBookingTableViewCell.h"

@interface HXBookingOfSucessTableViewCell : HXBookingTableViewCell

@property (nonatomic, strong) UIImageView *successImageView;

@property (nonatomic, strong) UIView *businessView;
@property (nonatomic, strong) UILabel *businessLabel;
@property (nonatomic, strong) UILabel *businessValueLabel;
@property (nonatomic, strong) UILabel *accountManagerLabel;
@property (nonatomic, strong) UILabel *accountManagerValueLabel;
@property (nonatomic, strong) UILabel *accountTelLabel;
@property (nonatomic, strong) UILabel *accountTelValueLabel;

@property (nonatomic, strong) UILabel *successTimeLabel;

@end
