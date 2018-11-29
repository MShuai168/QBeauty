//
//  HXPackageDetailTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/12/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPackageDetailTableViewCell.h"

@interface HXPackageDetailTableViewCell()

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIView *containImageView;

@end

@implementation HXPackageDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.containImageView];
    [self.containImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentTextView.mas_bottom);
    }];
}

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.scrollEnabled = NO;
        _contentTextView.editable = NO;
    }
    return _contentTextView;
}

- (UIView *)containImageView {
    if (!_containImageView) {
        _containImageView = [[UIView alloc] init];
    }
    return _containImageView;
}

- (void)setModel:(HXPackageDetailModel *)model {
    _model = model;
    NSMutableAttributedString * mutableAttributedString = [[NSMutableAttributedString alloc] initWithData:[model.detailContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.contentTextView.attributedText = mutableAttributedString;
    
    [self.containImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    __block UIImageView *preImageView = nil;
    __block float height = 0;
    
    [model.images enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString: obj];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        if (!image) {
            return ;
        }
        imageView.image = image;
        
        CGFloat persent= SCREEN_WIDTH/image.size.width;
        CGFloat imageHeight = image.size.height *persent;
        
        [self.containImageView addSubview:imageView];
        if (preImageView) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.containImageView);
                make.top.equalTo(preImageView.mas_bottom);
                make.height.mas_equalTo(imageHeight);
            }];
        } else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.containImageView);
                make.height.mas_equalTo(imageHeight);
            }];
        }
        
        height = height + imageHeight;
        preImageView = imageView;
    }];
    
    self.height = [self.contentTextView sizeThatFits:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)].height + height;
    
}

@end
