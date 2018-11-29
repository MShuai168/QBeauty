//
//  HXBookingTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/16.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXBookingTableViewCellViewModel.h"

@interface HXBookingTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *bookingNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *companyView;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *productValueLabel;
@property (nonatomic, strong) UILabel *iphoneLabel;
@property (nonatomic, strong) UILabel *iphoneValueLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *commentValueLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bottomLineView;


@property (nonatomic, strong) UILabel *orderTimeLabel;

@property (nonatomic, strong) HXBookingTableViewCellViewModel *viewModel;

- (void)setUpView;

@end
