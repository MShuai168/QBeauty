//
//  StoreListCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/18.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListModel.h"

@interface StoreListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  //店名
@property (weak, nonatomic) IBOutlet UILabel *addressLabel; //地址
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel; //预约电话
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;  //营业时间
@property (weak, nonatomic) IBOutlet UIImageView *addressImg;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (void)configCellWithModel:(StoreListModel *)model;

@end
