//
//  HomeDetailActivityCell.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailActivityModel.h"

@interface HomeDetailActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

- (void)configCellWithModel:(HomeDetailActivityModel *)model;

@end
