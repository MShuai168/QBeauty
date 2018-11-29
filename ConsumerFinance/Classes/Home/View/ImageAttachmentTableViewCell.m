//
//  ImageAttachmentTableViewCell.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/20.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "ImageAttachmentTableViewCell.h"

@interface ImageAttachmentTableViewCell ()

@end

@implementation ImageAttachmentTableViewCell

@synthesize uiTitle, uiChange, uiAdd;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15.f, 0.f, SCREEN_WIDTH-30.f, 230.f)];
        bgView.backgroundColor = COLOR_DEFAULT_WHITE;
        bgView.layer.cornerRadius = 8;
        bgView.layer.borderWidth = 0.5;
        bgView.layer.borderColor = COLOR_GRAY_MEDIUM.CGColor;
        [self.contentView addSubview:bgView];
        
        
        uiTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.f,
                                                            20.f,
                                                            150.f,
                                                            20.f)];
        uiTitle.textAlignment = NSTextAlignmentLeft;
        uiTitle.font = FONT_SYSTEM_SIZE(15.0f);
        uiTitle.textColor = COLOR_BLACK_DARK;
        [bgView addSubview:uiTitle];
        
        
        uiChange = [UIButton buttonWithType:UIButtonTypeCustom];
        uiChange.frame = CGRectMake((bgView.width - 80.f - 20.f),
                                  uiTitle.top,
                                  80.f,
                                  20.f);
        [uiChange addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        uiChange.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        uiChange.titleLabel.adjustsFontSizeToFitWidth = YES;
        [uiChange setTitle:@"更换" forState:UIControlStateNormal];
        uiChange.titleLabel.font = NormalFontWithSize(15.f);
        uiChange.enabled = NO;
        [uiChange setTitleColor:uiChange.enabled ? COLOR_BLUE_DARK : COLOR_GRAY_MEDIUM forState:UIControlStateNormal];
        [bgView addSubview:uiChange];
        //uiName.backgroundColor = ColorRandom;
        

        
        uiAdd = [[UIImageView alloc] initWithFrame:CGRectMake(40.f,
                                                             uiTitle.bottom + 15.f,
                                                             bgView.width - 80.f,
                                                              150.f)];
        uiAdd.userInteractionEnabled = YES;
        uiAdd.contentMode = UIViewContentModeScaleAspectFill;
        [uiAdd setImage:[UIImage imageNamed:@"addpicbg"]];
        [bgView addSubview:uiAdd];
        //uiAdd.layer.masksToBounds = YES;
        //uiAdd.backgroundColor = ColorRandom;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(clickEvent:)];
        [uiAdd addGestureRecognizer:tap];
        
        
        
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
        self.block(self, self.eventType);
    }
}

- (void)setTag:(NSInteger)tag {
    uiAdd.tag = tag;
    uiChange.tag = 100 + tag;
}

- (void)setTitle:(NSString *)title {
    uiTitle.text = [NSString isBlankString:title] ? @"" : title;
}

- (void)setEnableAdd:(BOOL)enableAdd {
    uiAdd.userInteractionEnabled = enableAdd;
}

- (void)setEnableChange:(BOOL)enableChange {
    uiChange.enabled = enableChange;
    [uiChange setTitleColor:enableChange ? COLOR_BLUE_DARK : COLOR_GRAY_MEDIUM forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
