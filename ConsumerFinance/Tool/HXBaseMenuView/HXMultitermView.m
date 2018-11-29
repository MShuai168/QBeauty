//
//  HXMultitermView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXMultitermView.h"
#import "HXMultCell.h"
#import "HXSelectedPath.h"
@interface HXMultitermView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) UITableView * rightTableView;
@property (nonatomic,assign) NSInteger selectedIndex; //选中的cell下标
@end
@implementation HXMultitermView
-(id)initWithItem:(HXItem *)item {
    self = [super init];
    if (self) {
        self.item = item;
        //获取上次选择的下标
        HXSelectedPath *selectedPath = [HXSelectedPath pathWithFirstPath:[self _findLeftSelectedIndex]];
        self.selectedIndex = [self _findLeftSelectedIndex];
        if ([self _findRightSelectedIndex:self.selectedIndex] != -1) {
            selectedPath.secondPath = [self _findRightSelectedIndex:self.selectedIndex];
        }
        [self.selectedArray addObject:selectedPath];
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
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = kUIColorFromRGB(0xffffff);
    [self addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(396);
    }];
    /**
     *  二级视图
     */
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = kUIColorFromRGB(0xf5f7f8);
    [self addSubview:_rightTableView];
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.left.equalTo(_leftTableView.mas_right).offset(0);
        make.height.mas_equalTo(396);
    }];
    UIButton * backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftTableView.mas_bottom).mas_offset(0);
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
    if ([tableView isEqual:_leftTableView]) {
        return self.item.dateArr.count;
    }else {
        return self.item.dateArr[_selectedIndex].dateArr.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    static NSString *cellIdentSec = @"cellIdentSec";
    if ([tableView isEqual:_leftTableView]) {
        
        HXMultCell *cell = (HXMultCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[HXMultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
            cell.selectedBackgroundView.backgroundColor = kUIColorFromRGB(0xf5f7f8);
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.highlightedTextColor = ComonBackColor;
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH/3, 0.5)];
            line.backgroundColor = HXRGB(221, 221, 221);
            [cell.contentView addSubview:line];
            
        }
        cell.item = [self.item.dateArr objectAtIndex:indexPath.row];
        return cell;
    }else
    {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentSec];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            cell.backgroundColor = kUIColorFromRGB(0xf5f7f8);
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH/3*2, 0.5)];
            line.backgroundColor = HXRGB(221, 221, 221);
            [cell.contentView addSubview:line];
        }
        HXItem * item = [self.item.dateArr[self.selectedIndex].dateArr objectAtIndex:indexPath.row];
        cell.textLabel.text = item.title ;
        NSLog(@"%d",item.selected);
        cell.textLabel.textColor = item.selected?ComonBackColor:ComonTextColor;
        return cell;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([tableView isEqual:_leftTableView]) {
        if (self.selectedIndex == indexPath.row) return;
        self.item.dateArr[indexPath.row].selected = YES;
        self.item.dateArr[_selectedIndex].selected = NO;
        _selectedIndex = indexPath.row ;
        [_leftTableView reloadData];
        [_rightTableView reloadData];
        return;
    }
    
    HXSelectedPath *selectdPath = [self.selectedArray lastObject];
    if (selectdPath.firstPath == self.selectedIndex && selectdPath.secondPath == indexPath.row){
        self.selectItem(nil);
        [self cancel];
        return;
        
    }
    HXItem * item = self.item.dateArr[selectdPath.firstPath];
    if (selectdPath.secondPath != -1) {
        HXItem *lastItem = item.dateArr[selectdPath.secondPath];
        lastItem.selected = NO;
        [self.selectedArray removeAllObjects];
    }
    HXItem *currentIndex =self.item.dateArr[self.selectedIndex].dateArr[indexPath.row];
    currentIndex.selected = YES;
    [self.selectedArray addObject:[HXSelectedPath pathWithFirstPath:self.selectedIndex secondPath:indexPath.row]];
    [self.rightTableView reloadData];
    
    self.selectItem(currentIndex.title,self.selectedIndex,indexPath.row);
    [self cancel];
}


#pragma mark - private method 获取第一批列表选择的下标
- (NSUInteger)_findLeftSelectedIndex {
    for (HXItem *item in self.item.dateArr) {
        if (item.selected) return [self.item.dateArr indexOfObject:item];
    }
    return MAXFLOAT;
}
#pragma mark -- 获取第二排选择的下标
- (NSInteger)_findRightSelectedIndex:(NSInteger)leftIndex {
    HXItem *item = self.item.dateArr[leftIndex];
    for (HXItem *subItem in item.dateArr) {
        if (subItem.selected) return [item.dateArr indexOfObject:subItem];
    }
    return -1;
}

#pragma mark --返回按钮
-(void)backButtonAction {
    self.selectItem(nil);
    [self dismiss];
}
#pragma mark --视图移除
-(void)cancel {
    HXSelectedPath *path = [self.selectedArray lastObject];
    if ([self _findLeftSelectedIndex] != path.firstPath) {
        self.item.dateArr[[self _findLeftSelectedIndex]].selected = NO;
        self.item.dateArr[path.firstPath].selected = YES;
    }
    [self dismiss];
}
-(void)dismiss {
    //消失的动画
    [UIView animateWithDuration:.25 animations:^{
        //        self.imageView.hidden = YES;
        [self.leftTableView removeFromSuperview];
        [self.rightTableView removeFromSuperview];
        self.leftTableView = nil;
        self.rightTableView = nil;
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
