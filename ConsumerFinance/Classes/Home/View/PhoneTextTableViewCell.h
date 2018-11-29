//
//  PhoneTextTableViewCell.h
//  ConsumerFinance
//
//  Created by Jney on 16/7/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDTextField.h"
@interface PhoneTextTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)HDTextField *areTextField;
@property(nonatomic,strong)HDTextField *phoneTextField;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *placeAreStr;
@property(nonatomic,strong)NSString *placePhoneStr;
@end
