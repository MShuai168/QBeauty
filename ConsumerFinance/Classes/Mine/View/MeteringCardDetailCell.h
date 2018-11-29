//
//  MeteringCardDetailCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrepaidCardModel.h"

@interface MeteringCardDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *residueLabel;

//次卡类型(1:有限   2：无限)
- (void)configCellWithModel:(MeteringCardDetailModel *)model withNumType:(int)type;

@end
