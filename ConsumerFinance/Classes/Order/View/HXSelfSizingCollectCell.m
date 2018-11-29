//
//  HXSelfSizingCollectCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/12/25.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXSelfSizingCollectCell.h"
#define itemHeight 15
@implementation HXSelfSizingCollectCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 用约束来初始化控件:
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textAlignment =NSTextAlignmentCenter;
        self.textLabel.textColor = ColorWithHex(0x4A90E2);
        self.textLabel.font =[UIFont systemFontOfSize:11];
        self.textLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:self.textLabel];
#pragma mark — 如果使用CGRectMake来布局,是需要在preferredLayoutAttributesFittingAttributes方法中去修改textlabel的frame的
        // self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        
#pragma mark — 如果使用约束来布局,则无需在preferredLayoutAttributesFittingAttributes方法中去修改cell上的子控件l的frame
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            // make 代表约束:
            make.top.equalTo(self.contentView).with.offset(0);   // 对当前view的top进行约束,距离参照view的上边界是 :
            make.left.equalTo(self.contentView).with.offset(0);  // 对当前view的left进行约束,距离参照view的左边界是 :
            make.height.mas_equalTo(15);                // 高度
            make.right.equalTo(self.contentView).with.offset(0); // 对当前view的right进行约束,距离参照view的右边界是 :
        }];
    }
    return self;
}

#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    CGFloat width = [Helper widthOfString:self.textLabel.text font:[UIFont systemFontOfSize:11] height:15];
    CGRect frame;
    frame.size.height = 15;
    frame.size.width = width;
    attributes.frame = CGRectMake(0, 0, width+5, 15);
    
    // 如果你cell上的子控件不是用约束来创建的,那么这边必须也要去修改cell上控件的frame才行
    // self.textLabel.frame = CGRectMake(0, 0, attributes.frame.size.width, 30);
    
    return attributes;
}
@end
