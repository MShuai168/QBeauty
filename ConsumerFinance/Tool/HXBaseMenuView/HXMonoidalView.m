//
//  HXMonoidalView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMonoidalView.h"
#import "HXSelectedPath.h"
@interface HXMonoidalView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end
@implementation HXMonoidalView
-(id)initWithItem:(HXItem *)item {
    self = [super init];
    if (self) {
        self.item = item;
        self.selectedArray = [NSMutableArray array];
        for (int i = 0; i < self.item.dateArr.count; i++) {
            HXItem *subItem = item.dateArr[i];
            if (subItem.selected == YES){
                HXSelectedPath *path = [[HXSelectedPath alloc] init];
                path.firstPath = i;
                [self.selectedArray addObject:path];
            }
        }
    }
    return self;
}
/**
 *  创建UI
 */
-(void)creatUI {
    /**
     *  一级视图
     */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(self.item.dateArr.count>6?6*44:self.item.dateArr.count*44);
    }];
    
    UIButton * backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).mas_offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.dateArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        cell.selectedBackgroundView.backgroundColor = kUIColorFromRGB(0xf5f7f8);
    }
    HXItem * item = [self.item.dateArr objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.backgroundColor = item.selected?kUIColorFromRGB(0xf5f7f8) : [UIColor whiteColor];
    cell.textLabel.textColor = item.selected?ComonBackColor:ComonTextColor;
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self _iscontainsSelectedPath:[HXSelectedPath pathWithFirstPath:indexPath.row] sourceArray:self.selectedArray]) {
        [self backButtonAction];
        return;
    }
    //remove
    if (self.selectedArray.count != 0) {
        HXSelectedPath *lastSelectedPath = self.selectedArray[0] ;
        self.item.dateArr[lastSelectedPath.firstPath].selected = NO;
        [self.selectedArray removeLastObject];
    }
    //add
    self.item.dateArr[indexPath.row].selected = YES;
    [self.selectedArray addObject:[HXSelectedPath pathWithFirstPath:indexPath.row]];
    self.selectItem([self.item.dateArr objectAtIndex:indexPath.row].title,indexPath.row);
    [self dismiss];
    
}
- (BOOL)_iscontainsSelectedPath:(HXSelectedPath *)path sourceArray:(NSMutableArray *)array{
    for (HXSelectedPath *selectedpath in array) {
        if (selectedpath.firstPath == path.firstPath ) return YES;
    }
    return NO;
}
#pragma mark --返回按钮
-(void)backButtonAction {
    self.selectItem(nil);
    [self dismiss];
}
#pragma mark --视图移除
-(void)dismiss {
    //消失的动画
    [UIView animateWithDuration:.25 animations:^{
        //        self.imageView.hidden = YES;
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
