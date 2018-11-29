//
//  MyTableViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface MyTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UIImageView * photoImage; //icon
@property (nonatomic,strong) UILabel * statesLabel;//标题
@property (nonatomic,strong) UILabel * numberLabel;
@end
