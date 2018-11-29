//
//  ContactInfoTableViewCell.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ContactInfoTableViewCell.h"

@interface ContactInfoTableViewCell ()

@end

@implementation ContactInfoTableViewCell
@synthesize uiContact, uiPhone, uiName, uiAdd, uiLine, uiPhoneButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15.f, 0.f, SCREEN_WIDTH-30.f, 60.f)];
        bgView.backgroundColor = COLOR_DEFAULT_WHITE;
        [self.contentView addSubview:bgView];
        
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = CGRectMake(0, 0, bgView.width, bgView.height);
        borderLayer.position = CGPointMake(bgView.centerX - 15.f, bgView.centerY);
        borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
        //borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
        borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
        //虚线边框
        borderLayer.lineDashPattern = @[@1, @1];
        //实线边框
        //borderLayer.lineDashPattern = nil;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = COLOR_GRAY_DARK.CGColor;
        [bgView.layer addSublayer:borderLayer];
        
        
        
        uiName = [UIButton buttonWithType:UIButtonTypeCustom];
        uiName.frame = CGRectMake(10.f,
                                  (bgView.height-50.f)/2,
                                  showScale*90.f,
                                  50.f);
        [uiName setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        //uiName.titleLabel.font = NumberFontWithSize(15);
        [uiName addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        //uiName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //uiName.titleLabel.adjustsFontSizeToFitWidth = YES;
        [uiName setTitleColor:COLOR_BLUE_DARK forState:UIControlStateNormal];
        [bgView addSubview:uiName];
        //uiName.backgroundColor = ColorRandom;
        
        
        
        uiLine = [[UIView alloc] initWithFrame:CGRectMake(showScale*(uiName.right + 10.f),
                                                          (bgView.height-50.f)/2,
                                                          0.5f,
                                                          50.f)];
        uiLine.backgroundColor = COLOR_GRAY_MEDIUM;
        [bgView addSubview:uiLine];
        
        
        
        uiPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        uiPhone.frame = CGRectMake(uiLine.right + 5.f,
                                  (bgView.height-50.f)/2,
                                   (bgView.width - 95.f - 15.f - uiLine.right - 5.f),
                                  50.f);
        
        [uiPhone addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        uiPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [uiPhone setTitleColor:COLOR_BLACK_DARK forState:UIControlStateNormal];
        [bgView addSubview:uiPhone];
        //uiPhone.backgroundColor = ColorRandom;
        
        
        
        
        //uiPhone.backgroundColor = ColorRandom;
        
        uiContact = [[UILabel alloc] initWithFrame:CGRectMake(bgView.width - 80.f - 15.f,
                                                              (bgView.height - 20.f)/2,
                                                              75.f,
                                                              20.f)];
        uiContact.textAlignment = NSTextAlignmentRight;
        uiContact.font = FONT_SYSTEM_SIZE(15.0f);
        if (SCREEN_WIDTH == 320) {
            uiContact.font = FONT_SYSTEM_SIZE(13.0f);
        }
        uiContact.textColor = COLOR_BLACK_DARK;
        [bgView addSubview:uiContact];
        //uiContact.backgroundColor = ColorRandom;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeRelation)];
        uiContact.userInteractionEnabled = YES;
        [uiContact addGestureRecognizer:tap];
#warning 修改电话号码按钮
        /*
        //修改电话号码按钮
        uiPhoneButton =[UIButton buttonWithType:UIButtonTypeCustom];
        uiPhoneButton.frame = CGRectMake(uiPhone.right + 3.f,
                                         (bgView.height-50.f)/2,
                                         44.0f,
                                         44.f);
        [uiPhoneButton setImage:[UIImage imageNamed:@"editname"] forState:UIControlStateNormal];
        [uiPhoneButton addTarget:self action:@selector(clickChangeEvent:) forControlEvents:UIControlEventTouchUpInside];
        uiPhoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [uiPhoneButton setTitleColor:COLOR_BLACK_DARK forState:UIControlStateNormal];
        [bgView addSubview:uiPhoneButton];
         */
#warning 修改电话号码按钮
        
        uiAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        uiAdd.frame = CGRectMake(15.f,
                                 (bgView.height-50.f)/2,
                                 bgView.width-30.f,
                                 50.f);
        uiAdd.titleLabel.textAlignment = NSTextAlignmentRight;
        [uiAdd addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        uiAdd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [uiAdd setTitle:@"＋  添加联系人" forState:UIControlStateNormal];
        [uiAdd setTitleColor:COLOR_BLUE_DARK forState:UIControlStateNormal];
        [bgView addSubview:uiAdd];
        
        uiLine.hidden = YES;
        [uiPhoneButton bringSubviewToFront:bgView];
        self.contentView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


- (void)clickEvent:(UIButton *)sender {
    
    [[UIApplication sharedApplication] sendAction: @selector(resignFirstResponder)
                                               to: nil
                                             from: nil
                                         forEvent: nil];
    if (self.block) {
        self.block(sender.tag);
    }
}


- (void) clickChangeEvent:(UIButton*)but{
    
    if (self.delegate) {
        [self.delegate changePhoneNumberByCell:self withType:_type];
        
    }
}

- (void)setRelation:(NSString *)relation {
    
    uiContact.text = [NSString isBlankString:relation] ? @"" : relation;
    if (SCREEN_WIDTH == 320 && relation.length > 4) {
        uiContact.font = NormalFontWithSize(11);
    }else{
        uiContact.font = NormalFontWithSize(15);
    }
    
    CGRect frame = uiContact.frame;
    [uiContact sizeToFit];
    uiContact.frame = CGRectMake(SCREEN_WIDTH-30.f - uiContact.width - 15.f, frame.origin.y, uiContact.width, frame.size.height);
    uiPhone.frame = CGRectMake(uiLine.right + 10.f,
                               (60.0f-50.f)/2,
                               120,
                               50.f);
    if (SCREEN_WIDTH == 320) {
        
        uiPhone.titleLabel.font = FONT_SYSTEM_SIZE(15.0f);
        uiPhone.frame = CGRectMake(uiLine.right + 5.f,
                                       (60-50.f)/2,
                                       110,
                                       50.f);
        uiPhoneButton.frame = CGRectMake(uiPhone.right,
                                         (60.f-50.f)/2,
                                         25.0f,
                                         50.f);
        
    }else{
        uiPhoneButton.frame = CGRectMake(uiPhone.right + 3.f,
                                         (60.f-50.f)/2,
                                         44.0f,
                                         50.f);
    }
}

- (void)setTag:(NSInteger)tag {
    uiAdd.tag = tag;
    uiName.tag = 100 + tag;
    uiPhone.tag = 200 + tag;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (void)changeRelation{
    if (self.delegate) {
        [self.delegate changeRelationByCell:self withType:_type];
        
    }
    
}

@end
