//
//  HXOrderStatusTagView.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/4/26.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXOrderStatusTagView.h"

@interface HXOrderStatusTagView()

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation HXOrderStatusTagView

- (instancetype)initWithTags:(NSArray *)tags selectedIndex:(int)selectedIndex isFirst:(BOOL)isFirst {
    if (self == [super init]) {
        _tags = tags;
        _isFirst = isFirst;
        _selectedIndex = selectedIndex;
        [self setUpTag];
    }
    return self;
}

- (void)setUpTag {
    UIImage *tagImage = [UIImage imageNamed:@"ordertag02"];
    
    int blockWidth = (SCREEN_WIDTH - tagImage.size.width*5)/4;
    
    UIView *tagView = [[UIView alloc] init];
    tagView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [tagView addSubview:lineView];
    lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(tagView).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    __block UIImageView *preImageView = nil;
    __block UIView *preBlockView = nil;
    
    [self.tags enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView00 = [[UIImageView alloc] init];
        UIImage *image00 = nil;
        if (self.selectedIndex == idx) {
            image00 = [UIImage imageNamed:@"ordertag01"];
        } else if(self.selectedIndex + 1 == idx) {
            image00 = [UIImage imageNamed:@"ordertag02"];
        } else {
            image00 = [UIImage imageNamed:@"ordertag03"];
        }
        imageView00.image = image00;
        [tagView addSubview:imageView00];
        if (preBlockView) {
            [imageView00 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tagView);
                make.left.equalTo(preBlockView.mas_right);
                make.bottom.equalTo(tagView.mas_bottom).offset(-1);
                make.width.mas_equalTo(tagImage.size.width);
            }];
        } else {
            [imageView00 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tagView);
                make.left.equalTo(tagView);
                make.bottom.equalTo(tagView.mas_bottom).offset(-1);
                make.width.mas_equalTo(image00.size.width);
            }];
        }


        UIView *forceView = [[UIView alloc] init];
        if (self.selectedIndex == idx) {
            forceView.backgroundColor = ColorWithHex(0xFAFAFA);
        } else {
            forceView.backgroundColor = [UIColor whiteColor];
        }
        
        [tagView addSubview:forceView];
        [forceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tagView);
            make.left.equalTo(imageView00.mas_right);
            make.bottom.equalTo(tagView).offset(-1);
            make.width.mas_equalTo(blockWidth);
        }];

        if (idx == 3) {
            [forceView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tagView);
                make.left.equalTo(imageView00.mas_right);
                make.bottom.equalTo(tagView).offset(-1);
                make.width.mas_equalTo(blockWidth + tagImage.size.width);
            }];
        }

        if (self.isFirst && idx == 0) {
            imageView00.hidden = YES;
            [forceView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tagView);
                make.left.equalTo(self);
                make.bottom.equalTo(tagView).offset(-1);
                make.width.mas_equalTo(blockWidth + tagImage.size.width);
            }];
        }

        UILabel *label01 = [[UILabel alloc] init];
        label01.text = obj;
        label01.font = [UIFont systemFontOfSize:13];
        if (self.selectedIndex == idx) {
            label01.textColor = ColorWithHex(0x4A90E2);
        } else {
            label01.textColor = ColorWithHex(0x666666);
        }
        [forceView addSubview:label01];
        [label01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(forceView);
            make.size.mas_equalTo(label01.intrinsicContentSize);
        }];

        preImageView = imageView00;
        preBlockView = forceView;
        
    }];
}

@end
