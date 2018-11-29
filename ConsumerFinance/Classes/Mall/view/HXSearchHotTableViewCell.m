//
//  HXSearchHotTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/27.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSearchHotTableViewCell.h"
#import "UIControl+HXCommandCategory.h"
#import "HXCommand.h"
#import "DistListModel.h"

@interface HXSearchHotTableViewCell()

@property (nonatomic, strong) UIButton *keyButton;

@end

@implementation HXSearchHotTableViewCell

- (instancetype)initWithHotName:(NSMutableArray *)nameArr {
    if (self == [super init]) {
        self.viewModel = [[HXSearchHotTableViewCellViewModel alloc] init];
        [self setUpkeyButton:nameArr];
    }
    return self;
}

- (void)setUpkeyButton:(NSMutableArray *)nameArr {
    int width = ([UIScreen mainScreen].bounds.size.width - 63)/4;
    int height = 30;
    __block UIButton *preBtn = nil;
    [nameArr enumerateObjectsUsingBlock:^(DistListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] init];
        btn.hx_command = self.hx_command;
        [btn addTarget:self action:@selector(keyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        if (idx%4 == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(15);
                make.top.equalTo(self.contentView).offset((idx / 4)*(height+10));
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }];
            preBtn = btn;
            return ;
        }
        
        if (preBtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preBtn.mas_right).offset(11);
                make.top.width.height.equalTo(preBtn);
            }];
        }
        
        preBtn = btn;
        
    }];
    [self.contentView layoutIfNeeded];
    
    self.viewModel.cellHeight = preBtn.frame.origin.y + preBtn.frame.size.height;
    
}

- (void)keyButtonClick:(UIButton *)button {
    [self.hx_command execute:button];
}

@end
