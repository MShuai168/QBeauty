//
//  BuyTableViewCell.h
//  ConsumerFinance
//
//  Created by Jney on 16/7/20.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDTextField.h"
@class BuyTableViewCell;
@protocol BuyTableViewCellDelegate <NSObject>

-(void)clickButton;

@end

typedef void (^clickEventBlock)(NSString *eventType);
@interface BuyTableViewCell : UITableViewCell

@property(nonatomic,weak)id<BuyTableViewCellDelegate> delegate;
/**
 *  控件
 */
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *desLabel;
@property(nonatomic,strong)HDTextField *textField;
@property(nonatomic,strong)UIButton *desBut;

@property (nonatomic, assign) UIKeyboardType    keyboardType;

@property (nonatomic, assign) BOOL   showBut;
@property (nonatomic, assign) BOOL   showLabel;
@property (nonatomic, assign) BOOL   showArrow;
@property (nonatomic, assign) BOOL   showBoth;

@property (nonatomic, strong) UIButton          *clickButton;
@property (nonatomic, assign) BOOL              clickEnable;
@property (nonatomic, strong) NSString          *eventType;
@property (nonatomic, copy  ) clickEventBlock   block;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *placeStr;
@property (nonatomic, strong) NSString *desStr;

@end
