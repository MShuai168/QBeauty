//
//  MyPositionTableViewCell.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "MyPositionTableViewCell.h"


@implementation MyPositionModel
@end


@interface MyPositionTableViewCell()
@property (nonatomic, strong) UILabel   *uiTitle;
@property (nonatomic, strong) UILabel   *uiSubTitle;
@property (nonatomic, strong) UIButton  *uiStatus;
@property (nonatomic, strong) UIImageView  *uiBgView;
@end

@implementation MyPositionTableViewCell

@synthesize uiTitle, uiSubTitle, uiStatus, uiBgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        uiBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                 0.f,
                                                                 SCREEN_WIDTH,
                                                                 168.f)];
        uiBgView.backgroundColor = COLOR_DEFAULT_WHITE;
        uiBgView.contentMode = UIViewContentModeScaleAspectFill;
        uiBgView.layer.masksToBounds = YES;
        uiBgView.userInteractionEnabled = YES;
        [self.contentView addSubview:uiBgView];
        
        
        uiTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.f,
                                                            30.f,
                                                            SCREEN_WIDTH - 40.f,
                                                            20.f)];
        uiTitle.textAlignment = NSTextAlignmentCenter;
        uiTitle.font = FONT_BOLD_SYSTEM_SIZE(18.0f);
        uiTitle.textColor = COLOR_DEFAULT_WHITE;
        [uiBgView addSubview:uiTitle];
        
        
        uiSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.f,
                                                               uiTitle.bottom + 10.f,
                                                               SCREEN_WIDTH - 40.f,
                                                               20.f)];
        uiSubTitle.textAlignment = NSTextAlignmentCenter;
        uiSubTitle.font = FONT_SYSTEM_SIZE(15.0f);
        uiSubTitle.textColor = COLOR_DEFAULT_WHITE;
        [uiBgView addSubview:uiSubTitle];
        
        
        uiStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        uiStatus.frame = CGRectMake((uiBgView.width - 150.f)/2,
                                    uiSubTitle.bottom + 20.f,
                                    150.f,
                                    40.f);
        [uiStatus addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        uiStatus.titleLabel.font = NormalFontWithSize(15.f);
        [uiStatus setTitleColor:COLOR_DEFAULT_WHITE forState:UIControlStateNormal];
        [uiStatus setTitle:@"立即分期" forState:UIControlStateNormal];
        [uiBgView addSubview:uiStatus];
        uiStatus.backgroundColor = COLOR_YELLOW_DARK;
        
        self.contentView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

- (void)clickEvent:(UIButton *)sender {
    if (self.block) {
        self.block(self);
    }
}


- (void)setObject:(MyPositionModel *)positionModel {
    if (!positionModel) {
        return;
    }
    uiBgView.image = [UIImage imageNamed:positionModel.imageName];
    uiTitle.text   = positionModel.title;
    uiSubTitle.text = positionModel.subTitle;
    
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





