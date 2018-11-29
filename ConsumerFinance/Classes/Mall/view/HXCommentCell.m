//
//  HXCommentCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCommentCell.h"
#import "StarView.h"
#import "AcdseeCollection.h"
#import "HXStarView.h"
#define UILABEL_LINE_SPACE 2
#define defaultHeight 100
@interface HXCommentCell()
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) AcdseeCollection * acd;
@property (nonatomic,strong) UIButton * allcountBtn;
@property (nonatomic,strong)HXCommentModel * selectModel;
@property (nonatomic,strong)UILabel * fwLabel;
@property (nonatomic,strong)UILabel * zlLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)HXStarView* star;

@end
@implementation HXCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    /**
     * 头像
     */
    UIImageView * headImage = [[UIImageView alloc] init];
    self.headImage = headImage;
    headImage.layer.cornerRadius = 40/2;
    headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.width.and.height.mas_equalTo(40);
    }];
    /**
     * 名称
     */
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    nameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11.5);
        make.left.equalTo(self.contentView).offset(70);
        make.height.mas_equalTo(15);
    }];
    /**
     * 打分
     */
    UILabel * dfLabel = [[UILabel alloc] init];
    dfLabel.font = [UIFont systemFontOfSize:11];
    dfLabel.textColor = kUIColorFromRGB(0x666666);
    dfLabel.text = @"打分";
    [self.contentView addSubview:dfLabel];
    [dfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(34);
        make.left.equalTo(self.contentView).offset(70);
        make.height.mas_equalTo(11);
    }];
    
    /**
     *  星星
     */
    HXStarView* star = [[HXStarView alloc] init];
    self.star = star;
    [self.contentView addSubview:star];
    [star  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dfLabel);
        make.left.equalTo(dfLabel.mas_right).offset(5);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(115);
    }];
    /**
     *  服务
     */
    UILabel * fwLabel  = [[UILabel alloc] init];
    self.fwLabel = fwLabel;
    fwLabel.font = [UIFont systemFontOfSize:12];
    fwLabel.textColor = ComonCharColor;
    [self.contentView addSubview:fwLabel];
    [fwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(star);
        make.left.equalTo(star.mas_right).offset(15);
    }];
    /**
     *  质量
     */
    UILabel * zlLabel = [[UILabel alloc] init];
    self.zlLabel = zlLabel;
    zlLabel.hidden = SCREEN_WIDTH>320?NO:YES;
    zlLabel.font = [UIFont systemFontOfSize:12];
    zlLabel.textColor = ComonCharColor;
    [self.contentView addSubview:zlLabel];
    [zlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fwLabel.mas_right).offset(10);
        make.centerY.equalTo(star);
    }];
    
    /**
     *  日期
     */
    UILabel * dateLabel = [[UILabel alloc] init];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:11];
    dateLabel.textColor = ComonCharColor ;
    [self.contentView addSubview:dateLabel];
    [dateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(11.5);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    /**
     *  评论内容
     */
    UILabel * contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:contentLabel];
    [contentLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(55);
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.contentView).offset(70);
    }];
    
    UIButton * allcountBtn = [[UIButton alloc] init];
    self.allcountBtn = allcountBtn;
    [allcountBtn setTitle:@"全文" forState:UIControlStateNormal];
    [allcountBtn addTarget:self action:@selector(allcountBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [allcountBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    allcountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [allcountBtn setTitleColor:kUIColorFromRGB(0x4A90E2) forState:UIControlStateNormal];
    [self.contentView addSubview:allcountBtn];
    [allcountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(70);
        make.top.equalTo(contentLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(0);
    }];
    
    AcdseeCollection * acd = [[AcdseeCollection alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH, 0)];
    self.acd = acd;
    [self.contentView addSubview:acd];
    [acd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allcountBtn.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.contentView);
    }];
    
}
-(void)setHxcModel:(HXCommentModel *)hxcModel {
    self.selectModel = hxcModel;
    self.contentLabel.text = hxcModel.content;
    [self setLabelSpace:self.contentLabel withValue:hxcModel.content withFont:[UIFont systemFontOfSize:13]];
    self.fwLabel.text = [NSString stringWithFormat:@"服务: %@",hxcModel.serviceScore.length?hxcModel.serviceScore:@"0"];
    self.zlLabel.text = [NSString stringWithFormat:@"质量: %@",hxcModel.qualityScore.length?hxcModel.qualityScore:@"0"];
    self.dateLabel.text = hxcModel.commentDate.length!=0?hxcModel.commentDate:@"";
    self.star.star = hxcModel.countScore?[hxcModel.countScore doubleValue]:0.00;
    [self.star layoutSubviews];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:hxcModel.icon] placeholderImage:[UIImage imageNamed:@"toxiang"]];
    [self.allcountBtn setTitle:hxcModel.seeAll?@"收起":@"全文" forState:UIControlStateNormal];
    self.nameLabel.text = hxcModel.cellPhone.length!=0?hxcModel.cellPhone:@"";
    if (hxcModel.contentLength && !hxcModel.seeAll) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(defaultHeight);
        }];
    }else {
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hxcModel.titleHeight);
        }];
        
    }
    [self.acd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hxcModel.photoHeight);
    }];
    
    self.acd.imageArr = hxcModel.photoArr;
    if (hxcModel.photoArr.count!=0) {
        self.acd.hidden = NO;
        [self.acd creatSectionCollection:hxcModel.photoHeight];
    }else {
        self.acd.hidden = YES;
    }
    
    if (hxcModel.contentLength) {
        if (hxcModel.photoArr.count==0) {
            [self.allcountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
            }];
        }else {
            [self.allcountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(36);
            }];
        }
        self.allcountBtn.hidden =NO;
    }else {
        [self.allcountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.allcountBtn.hidden = YES;
    }
}

-(void)allcountBtnAction {
    if (!self.selectModel.contentLength) {
        return;
    }
    self.selectModel.seeAll = !self.selectModel.seeAll;
    NSInteger height = self.selectModel.contentLength?self.selectModel.photoArr.count==0?20:36:0;
    NSInteger heightLength =self.selectModel.seeAll?self.selectModel.titleHeight:defaultHeight;
    [CATransaction begin];
    self.selectModel.cellHeight = 65+heightLength+self.selectModel.photoHeight+ height+10;
    if ([self.delegate respondsToSelector:@selector(updateTableViewHeight)]) {
        [self.delegate updateTableViewHeight];
    }
    
    [CATransaction setCompletionBlock:^{
        // animation has finished
        if (!self.selectModel.seeAll) {
            [UIView animateWithDuration:.3f animations:^{
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(defaultHeight);
            }];
            [self.contentView layoutIfNeeded];
            } completion:^(BOOL finished) {
                
                [self.allcountBtn setTitle:@"全文" forState:UIControlStateNormal];
            }];
            
        }else {
            [UIView animateWithDuration:.3f animations:^{
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.selectModel.titleHeight);
            }];
                [self.contentView layoutIfNeeded];
            } completion:^(BOOL finished) {
                
                [self.allcountBtn setTitle:@"收起" forState:UIControlStateNormal];
            }];
            
        }
    }];
    
   
    
}


-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
