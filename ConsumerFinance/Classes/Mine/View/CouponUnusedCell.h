//
//  CouponUnusedCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/21.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponListModel.h"

@interface CouponUnusedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *markedLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;


- (void)configCellWithModel:(CouponListModel *)model withType:(int)type;

@end
