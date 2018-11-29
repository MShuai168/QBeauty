//
//  PhoneTextTableViewCell.m
//  ConsumerFinance
//
//  Created by Jney on 16/7/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "PhoneTextTableViewCell.h"
static const CGFloat leftPadding        = 15;
static const CGFloat titleWidth         = 75;
static const CGFloat titleHeight        = 20;
static const CGFloat areTextWidth       = 40;

@implementation PhoneTextTableViewCell
{
    UILabel *_lineLabel;
    
}

@synthesize titleLabel, areTextField, phoneTextField;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,
                                                               (self.height-titleHeight)/2,
                                                               titleWidth,
                                                               titleHeight)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = FONT_SYSTEM_SIZE(15.0f);
        titleLabel.textColor = COLOR_BLACK_DARK;
        [self.contentView addSubview:titleLabel];
        //titleLabel.backgroundColor = ColorRandom;
        
        
        areTextField = [[HDTextField alloc] initWithFrame:CGRectMake(titleLabel.right+5, 0, areTextWidth, self.height)];
        areTextField.clearsOnBeginEditing = NO;
        areTextField.textColor = COLOR_BLACK_DARK;
        areTextField.keyboardType = UIKeyboardTypeNumberPad;
        //areTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        areTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        areTextField.font = FONT_SYSTEM_SIZE(15);
        [self.contentView addSubview:areTextField];
        
        //textField.backgroundColor = ColorRandom;
        
        /**
         *  横线
         */
        
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(areTextField.right+5, (self.height-0.5)/2, 40, 0.5)];
        _lineLabel.backgroundColor = HXRGB(51, 51, 51);
        [self.contentView addSubview:_lineLabel];
        
        
        phoneTextField = [[HDTextField alloc] initWithFrame:CGRectMake(_lineLabel.right+10, 0, SCREEN_WIDTH-10-_lineLabel.right-5, self.height)];
        phoneTextField.clearsOnBeginEditing = NO;
        phoneTextField.textColor = COLOR_BLACK_DARK;
        phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        phoneTextField.font = FONT_SYSTEM_SIZE(15);
        [self.contentView addSubview:phoneTextField];
        
        
        self.contentView.backgroundColor  = COLOR_DEFAULT_WHITE;
        
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr{
    titleLabel.text = titleStr;
}

- (void)setPlaceAreStr:(NSString *)placeAreStr{
    areTextField.placeholder = placeAreStr;
}

- (void)setPlacePhoneStr:(NSString *)placePhoneStr{
    phoneTextField.placeholder = placePhoneStr;
}
@end
