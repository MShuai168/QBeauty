//
//  TextFieldTableViewCell.h
//  TextfieldCellDemo
//
//  Created by 侯荡荡 on 16/7/12.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDTextField.h"
#import "HXButton.h"
typedef void (^clickEventBlock)(NSString *eventType);

@interface TextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) HDTextField       *textField;
@property (nonatomic, strong) NSString          *placeHolder;
@property (nonatomic, strong) NSString          *text;
@property (nonatomic, assign) NSTextAlignment   alignment;
@property (nonatomic, assign) UIKeyboardType    keyboardType;
@property (nonatomic, assign) BOOL              editEnabled;

@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) NSString          *title;

@property (nonatomic, assign) BOOL              showArrow;
@property (nonatomic, assign) BOOL              showButton;
/**
 *  按钮
 */
@property (nonatomic, strong) UIColor           *butColor;
@property (nonatomic, assign) CGFloat           fontSize;
@property (nonatomic, strong) UIButton          *imgButton;
@property (nonatomic, strong) NSString          *butTitleStr;
@property (nonatomic, assign) CGFloat           butWidth;

/**
 *  显示短信验证码
 */
@property (nonatomic, strong) HXButton          *SMSButton;
@property (nonatomic, assign) BOOL              showSMSBut;



@property (nonatomic, strong) UIButton          *clickButton;
@property (nonatomic, assign) BOOL              clickEnable;
@property (nonatomic, strong) NSString          *eventType;
@property (nonatomic, copy  ) clickEventBlock   block;


@property (nonatomic, assign) CGRect           textFieldFrame;
@property (nonatomic, assign) CGRect           titleLabelFrame;
@property (nonatomic, assign) CGRect           lineFrame;

@property (nonatomic, strong) UIView           *line;



@end
