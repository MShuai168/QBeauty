//
//  BuyTableViewCell.m
//  ConsumerFinance
//
//  Created by Jney on 16/7/20.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "BuyTableViewCell.h"
@interface BuyTableViewCell ()
@property(nonatomic,strong)UILabel *line;
@end
static const CGFloat leftPadding        = 15;
static const CGFloat titleWidth         = 95;
static const CGFloat titleHeight        = 20;
static const CGFloat butHeight          = 25;
static const CGFloat butWidth          = 40;
@implementation BuyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _line = [[UILabel alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = HXRGB(221, 221, 221);
        [self.contentView addSubview:_line];
        
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,
                                                               (self.height-titleHeight)/2,
                                                               titleWidth,
                                                               titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = FONT_SYSTEM_SIZE(15.0f);
        _titleLabel.textColor = COLOR_BLACK_DARK;
        [self.contentView addSubview:_titleLabel];
        //titleLabel.backgroundColor = ColorRandom;
        
        
        _textField = [[HDTextField alloc] initWithFrame:CGRectZero];
        _textField.clearsOnBeginEditing = NO;
        _textField.textColor = COLOR_BLACK_DARK;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.font = FONT_SYSTEM_SIZE(15);
        [self.contentView addSubview:_textField];
        
        //textField.backgroundColor = ColorRandom;
        
        
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height);
        [_clickButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_clickButton];
        
        
        _desBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _desBut.frame = CGRectMake(SCREEN_WIDTH-leftPadding-butWidth, 5, butWidth, butHeight);
        [_desBut addTarget:self action:@selector(tryNum) forControlEvents:UIControlEventTouchUpInside];
        [_desBut.layer setMasksToBounds:YES];
        [_desBut.layer setCornerRadius:6];
        [_desBut.layer setBorderWidth:0.5];
        [_desBut.layer setBorderColor:HXRGB(60, 155, 255).CGColor];
        [_desBut setTitle:@"试算" forState:UIControlStateNormal];
        _desBut.titleLabel.font = [UIFont systemFontOfSize:15];
        [_desBut setTitleColor:HXRGB(60, 155, 255) forState:UIControlStateNormal];
        [self.contentView addSubview:_desBut];
        
        
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-leftPadding-165, (self.height-15)/2, 165, 15)];
        _desLabel.text = @"元";
        _desLabel.textColor = HXRGB(151, 151, 151);
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_desLabel];
        
        
        self.contentView.backgroundColor  = COLOR_DEFAULT_WHITE;
        
        self.showBut = NO;
        self.showLabel = NO;
        self.showArrow = NO;
        self.clickEnable = NO;
        
        _clickButton.hidden = !self.clickEnable;
        
    }
    return self;
}

-(void)setShowBut:(BOOL)showBut{
    _showBut = showBut;
    _desBut.hidden = !showBut;
}

-(void)setShowLabel:(BOOL)showLabel{
    _showLabel = showLabel;
    _desLabel.hidden = !showLabel;
}

-(void)setShowBoth:(BOOL)showBoth{
    _showBoth = showBoth;
    _desLabel.hidden = !showBoth;
    _desBut.hidden = !showBoth;
}

- (void)setShowArrow:(BOOL)showArrow {
    self.accessoryType = showArrow ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

- (void)setClickEnable:(BOOL)clickEnable {
    _clickButton.hidden = !clickEnable;
    self.textField.enabled = !clickEnable;
}

-(void)setTitleStr:(NSString *)titleStr{

    _titleLabel.text = titleStr;
}

-(void)setPlaceStr:(NSString *)placeStr{
    _textField.placeholder = placeStr;
}

-(void)setDesStr:(NSString *)desStr{
    _desLabel.text = desStr;
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

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    if (keyboardType) {
        self.textField.keyboardType = keyboardType;
    }
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _titleLabel.top = (self.height - titleHeight)/2;
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        _textField.frame = CGRectMake(_titleLabel.right + 5,
                                     0,
                                     self.width - (_titleLabel.right + 5) - 35,
                                     self.height);
    }
    if (!_desBut.hidden){
        _desBut.frame = CGRectMake(SCREEN_WIDTH-leftPadding-butWidth, (self.height-butHeight)/2, butWidth, butHeight);
        _textField.frame = CGRectMake(_titleLabel.right + 5,
                                     0,
                                     self.width - (_titleLabel.right + 5) - butWidth-15,
                                     self.height);
        
    }
    if (!_desLabel.hidden){
        _desLabel.frame = CGRectMake(SCREEN_WIDTH-leftPadding-165, (self.height-15)/2, 165, 15);
        _textField.frame = CGRectMake(_titleLabel.right + 5,
                                     0,
                                     self.width - (_titleLabel.right + 5) - 10 - leftPadding,
                                     self.height);
        
    }
    if (_showBoth){
        _desBut.frame = CGRectMake(SCREEN_WIDTH-leftPadding-butWidth, (self.height-butHeight)/2, butWidth, butHeight);
        _desLabel.frame = CGRectMake(_desBut.left-10-15, (self.height-15)/2, 15, 15);

        _textField.frame = CGRectMake(_titleLabel.right + 5,
                                     0,
                                     self.width - (_titleLabel.right + 5) - 10 - _desLabel.width - _desBut.width,
                                     self.height);
    }
    
    _line.frame = CGRectMake(15, self.height - 0.5, SCREEN_WIDTH - 15, 0.5);
}

-(void) tryNum{
    if (self.delegate) {
        [self.delegate clickButton];
    }
    
}
@end
