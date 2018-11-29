//
//  TextFieldTableViewCell.m
//  TextfieldCellDemo
//
//  Created by 侯荡荡 on 16/7/12.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "TextFieldTableViewCell.h"

static const CGFloat leftPadding        = 15;
static const CGFloat titleWidth         = 80;
static const CGFloat titleHeight        = 45;
static const CGFloat butHeight          = 40;


@implementation TextFieldTableViewCell
@synthesize titleLabel, textField, editEnabled, clickButton, imgButton, SMSButton,line;

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
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        //titleLabel.backgroundColor = ColorRandom;
        
        
        textField = [[HDTextField alloc] init];
        textField.frame = CGRectZero;
        textField.clearsOnBeginEditing = NO;
        textField.textColor = COLOR_BLACK_DARK;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = FONT_SYSTEM_SIZE(15);
        [self.contentView addSubview:textField];
        
        //textField.backgroundColor = ColorRandom;
        
        
        clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clickButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height);
        [clickButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:clickButton];
        
        
        imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imgButton.frame = CGRectMake(SCREEN_WIDTH-leftPadding-_butWidth, 5, _butWidth, butHeight);
        imgButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [imgButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:imgButton];

        
        SMSButton = [[HXButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-leftPadding-_butWidth, 5, _butWidth, butHeight)];
        [SMSButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:SMSButton];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(SMSButton.left, 0, 0.5, 50)];
        line.backgroundColor = HXRGB(153, 153, 153);
        [self.contentView addSubview:line];
        
        line.hidden = YES;
        
        self.contentView.backgroundColor  = COLOR_DEFAULT_WHITE;
        
        self.editEnabled = YES;
        self.showArrow   = NO;
        self.clickEnable = NO;
        self.showButton = NO;
        self.showSMSBut = NO;
        
        clickButton.hidden = !self.clickEnable;
    }
    return self;
}

- (void)setTextField:(HDTextField *)textField{


}

- (void)clickEvent:(id)sender {
    
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder)
                                               to: nil
                                             from: nil
                                         forEvent: nil];
    if (self.block) {
        self.block(self.eventType);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    titleLabel.top = (self.height - titleHeight)/2;
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        textField.frame = CGRectMake(titleLabel.right + 5,
                                     0,
                                     self.width - (titleLabel.right + 5) - 35,
                                     self.height);
    } else if (!imgButton.hidden){
        imgButton.frame = CGRectMake(SCREEN_WIDTH-leftPadding-_butWidth+10, 5, _butWidth, butHeight);
        textField.frame = CGRectMake(titleLabel.right + 5,
                                     0,
                                     self.width - (titleLabel.right + 5) - _butWidth-15,
                                     self.height);
    
    } else if (!SMSButton.hidden){
        SMSButton.frame = CGRectMake(SCREEN_WIDTH-leftPadding-_butWidth+10, 5, _butWidth, butHeight);
        textField.frame = CGRectMake(titleLabel.right + 5,
                                     0,
                                     self.width - (titleLabel.right + 5) - _butWidth-15,
                                     self.height);
        
    } else if (self.accessoryView){
        textField.frame = CGRectMake(titleLabel.right + 5,
                                     0,
                                     self.width - (titleLabel.right + 5) - self.accessoryView.width - 10,
                                     self.height);
    } else{
        textField.frame = CGRectMake(titleLabel.right + 5,
                                     0,
                                     self.width - (titleLabel.right + 5) - 10,
                                     self.height);
    }
    
}

- (void)setAlignment:(NSTextAlignment)alignment {
    if (alignment) {
        self.textField.textAlignment = alignment;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    if (keyboardType) {
        self.textField.keyboardType = keyboardType;
    }
}

- (void)setText:(NSString *)text {
    self.textField.text = [NSString isBlankString:text] ? @"" : text;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.textField.placeholder = [NSString isBlankString:placeHolder] ? @"" : placeHolder;
}

- (void)setShowArrow:(BOOL)showArrow {
    self.accessoryType = showArrow ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

- (void)setShowButton:(BOOL)showButton{
    self.imgButton.hidden = !showButton;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    if (!editEnabled){
        self.textField.enabled = editing;
    }
}

- (void) setShowSMSBut:(BOOL)showSMSBut{
    
    self.SMSButton.hidden = !showSMSBut;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = ([NSString isBlankString:title])? @"" : title;
}

- (void)setClickEnable:(BOOL)clickEnable {
    clickButton.hidden = !clickEnable;
    self.textField.enabled = !clickEnable;
}

- (void)setButColor:(UIColor *)butColor{
    [imgButton setTitleColor:butColor forState:UIControlStateNormal];
}

- (void)setTextFieldFrame:(CGRect)textFieldFrame{

    textField.frame = textFieldFrame;
}

-(void)setTitleLabelFrame:(CGRect)titleLabelFrame{

    titleLabel.frame = titleLabelFrame;
}

-(void)setLineFrame:(CGRect)lineFrame{

    line.frame = lineFrame;
}

- (void)setFontSize:(CGFloat)fontSize{
    
    imgButton.titleLabel.font = NumberFontWithSize(fontSize);
}

- (void)setButTitleStr:(NSString *)butTitleStr{
    
    [imgButton setTitle:butTitleStr forState:UIControlStateNormal];
}
@end
