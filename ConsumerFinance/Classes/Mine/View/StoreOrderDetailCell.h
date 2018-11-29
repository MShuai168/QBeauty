//
//  StoreOrderDetailCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreOrderListModel.h"

@interface StoreOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *refundLabel;  //退款

- (void)configCellWithModel:(StoreOrderDetailModel *)model;

@end
