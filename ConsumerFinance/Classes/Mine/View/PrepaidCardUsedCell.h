//
//  PrepaidCardUsedCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/23.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrepaidCardModel.h"

@interface PrepaidCardUsedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

- (void)configCellWithModel:(PrepaidCardModel *)model withType:(int)type;

@end
