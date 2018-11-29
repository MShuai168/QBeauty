//
//  HXListButton.m
//  demo
//
//  Created by Jney on 2016/11/9.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import "HXListButton.h"
#import "TableListCell.h"

const CGFloat View_height = 200;

@interface HXListButton ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *tableview;
@property (nonatomic,strong) UILabel        *selectLabel;
@property (nonatomic,strong) UIButton       *selectBut;
@property (nonatomic,strong) UIImageView    *iconImg;
@property (nonatomic,assign) CGRect         frameView;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) CellModel      *model;

@end


@implementation HXListButton
@synthesize tableview, selectLabel, frameView, dataList,model, selectBut, iconImg;

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)list{
    self = [super initWithFrame:frame];
    if (self) {

        frameView = frame;
        dataList = [NSMutableArray array];
        for (NSInteger i = 0; i < list.count; i++) {
            NSString *title = list[i];
            model = [[CellModel alloc] init];
            model.titleStr = title;
            model.isChoose = i == 0 ? YES : NO;
            [dataList addObject:model];
        }
        
        CGFloat height = frame.size.height;
    
        //
        //按钮
        selectBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        selectLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectLabel];
        selectLabel.text = [list firstObject];
        selectLabel.textColor = ColorWithRGB(255, 132, 0);
        selectLabel.numberOfLines = 0;
        selectLabel.font = [UIFont systemFontOfSize:15];
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 15 - 12, (frame.size.height-12)/2.0, 12, 12)];
        iconImg.image = [UIImage imageNamed:@"name_arrow"];
        [self addSubview:iconImg];
        [selectBut addTarget:self action:@selector(showMoreItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBut];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, height-0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = ColorWithRGB(221, 221, 221);
        [self addSubview:line];

        
        //tableView
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, frameView.size.height, frameView.size.width, 0) style:UITableViewStylePlain];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.delegate = self;
        tableview.dataSource = self;
        [self addSubview:tableview];
        tableview.backgroundColor = ColorWithRGB(242, 242, 242);
        if (list.count == 1) {
            iconImg.hidden = YES;
            selectBut.hidden = YES;
        }else{
            iconImg.hidden = NO;
            selectBut.hidden = NO;
        }
    }
    return self;
}

#pragma mark - 私有方法
- (void)showMoreItem:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    [self changeFrameView];
}

//修改尺寸
- (void) changeFrameView{
    iconImg.image = selectBut.selected ? [UIImage imageNamed:@"name_up"] : [UIImage imageNamed:@"name_arrow"];
    if (selectBut.selected) {
        //展开  选中
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(frameView.origin.x, frameView.origin.y, frameView.size.width, View_height);
            tableview.frame = CGRectMake(0, frameView.size.height, frameView.size.width, (NSInteger)40*dataList.count < (NSInteger)View_height ? 40*dataList.count : View_height);
            NSLog(@"");
        } completion:nil];
    }else{
        //隐藏  未选中
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(frameView.origin.x, frameView.origin.y, frameView.size.width, frameView.size.height);
            tableview.frame = CGRectMake(0, frameView.size.height, frameView.size.width, 0);
        } completion:^(BOOL finished) {
            [tableview reloadData];
        }];
    }
    

}

#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    if (!cell) {
        cell = [[TableListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    cell.model = dataList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *selectIndex;
    
    for (NSInteger i = 0; i < dataList.count; i++) {
        CellModel *modelA = dataList[i];
        if (modelA.isChoose) {
            selectIndex = [NSIndexPath indexPathForRow:i inSection:0];
        }
        modelA.isChoose = (i == indexPath.row) ? YES : NO;
        
    }
    CellModel *modelChoose = dataList[indexPath.row];
    selectLabel.text = modelChoose.titleStr;
    selectBut.selected = NO;
    [tableview reloadRowsAtIndexPaths:@[selectIndex,indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self changeFrameView];
    
}
@end


@implementation CellModel


@end

