//
//  SheetView.m
//  CustomSheetView
//
//  Created by 侯荡荡 on 16/11/30.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "SheetView.h"

@interface SheetView ()
<UITableViewDelegate, UITableViewDataSource, SheetTableViewCellDelegate>
@property (nonatomic, strong) UITableView *sheetTableView;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) UIButton *sheetButton;
@property (nonatomic, assign) CGFloat sheetViewHeight;
@property (nonatomic, assign) CGFloat tableViewHeight;
@end

#define mainScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define mainScreenWidth   [[UIScreen mainScreen] bounds].size.width

const CGFloat leftPadding       = 15.f;
const CGFloat toolBarHeight     = 44.f;
const CGFloat sheetButtonHeight = 44.f;
const CGFloat cellHeight        = 44.f;

@implementation SheetView

- (instancetype)initWithTitle:(NSString *)title dataSource:(NSMutableArray *)dataSource delegate:(id <SheetViewDelegate>)delegate sheetButtonTitle:(NSString *)sheetButtonTitle {
    
    if (self = [super init]) {
        self.frame           = CGRectMake(0, 0, mainScreenWidth, mainScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.hidden          = YES;
        
        self.sheetDataSource = [dataSource mutableCopy];
        self.delegate        = delegate;
        
        self.sheetViewHeight = MIN(mainScreenHeight * 2/3, toolBarHeight + sheetButtonHeight + dataSource.count * cellHeight);
        self.tableViewHeight = self.sheetViewHeight - toolBarHeight - sheetButtonHeight;
        
        self.sheetView       = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        mainScreenHeight,
                                                                        self.bounds.size.width,
                                                                        self.sheetViewHeight)];
        self.sheetView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sheetView];
        
        
        UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, toolBarHeight)];
        [toolbar setBackgroundColor:[UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1]];
        [self.sheetView addSubview:toolbar];
        
        UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,
                                                                        0.f,
                                                                        (toolbar.frame.size.width - 30.f)/2,
                                                                        toolbar.frame.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font          = [UIFont systemFontOfSize:14.f];
        label.textColor     = [UIColor blackColor];
        label.numberOfLines = 0;
        label.text          = title ?: @"标题";
        label.adjustsFontSizeToFitWidth = YES;
        [toolbar addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(toolbar.frame) - leftPadding - 60, 0.f, 60.f, toolbar.frame.size.height);
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button addTarget:self action:@selector(closeSheetView) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:button];
        
        
        self.sheetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                            toolBarHeight,
                                                                            self.sheetView.bounds.size.width,
                                                                            self.tableViewHeight)
                                                           style:UITableViewStylePlain];
        self.sheetTableView.delegate        = self;
        self.sheetTableView.dataSource      = self;
        self.sheetTableView.backgroundColor = [UIColor whiteColor];
        self.sheetTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [self.sheetView addSubview:self.sheetTableView];
        
        
        self.sheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sheetButton.frame = CGRectMake(0,
                                            CGRectGetHeight(self.sheetView.frame) - sheetButtonHeight,
                                            CGRectGetWidth(self.sheetView.frame),
                                            sheetButtonHeight);
        [self.sheetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sheetButton setTitle:sheetButtonTitle ?: @"点击事件" forState:UIControlStateNormal];
        [self.sheetButton setBackgroundColor:[UIColor purpleColor]];
        [self.sheetButton.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [self.sheetButton addTarget:self action:@selector(sheetEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.sheetView addSubview:self.sheetButton];
        
    }
    return self;
}

- (void)displaySheetView {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden     = NO;
        CGRect frame    = self.sheetView.frame;
        frame.origin.y  = mainScreenHeight - self.sheetViewHeight;
        self.sheetView.frame = frame;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }];
    
}

- (void)closeSheetView {
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame    = self.sheetView.frame;
        frame.origin.y  = mainScreenHeight;
        self.sheetView.frame = frame;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        if (finished) [self removeFromSuperview];
    }];
}

#pragma mark - SheetViewDelegate
- (void)sheetEvent:(id)sender {
    [self closeSheetView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetView:sheetButtonEvent:)]) {
        [self.delegate sheetView:self sheetButtonEvent:sender];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sheetDataSource count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId  = @"cell";
    SheetTableViewCell *cell = [self.sheetTableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellId];
        cell.cellDelegate = self;
    }
    [cell setObject:self.sheetDataSource[indexPath.row]];
    [cell totalCount:self.sheetDataSource.count currentIndex:indexPath.row];
    return cell;
}

#pragma mark - SheetTableViewCellDelegate
- (void)sheetTablewViewCell:(SheetTableViewCell *)tableViewCell deleteData:(id)sneder {
    NSIndexPath *indexPath = [self.sheetTableView indexPathForCell:tableViewCell];
    if (!indexPath) return;
    if (indexPath.row < self.sheetDataSource.count - 1) return;
    [self.sheetDataSource removeObjectAtIndex:indexPath.row];
    [self.sheetTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.sheetTableView reloadData];
    if (self.sheetDataSource.count == 0) [self closeSheetView];
}
@end



@implementation SheetViewDataModel
@end


@implementation SheetTableViewCell
@synthesize titleLabel, subTitleLabel, contentLabel, deleteButton, line;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        //titleLabel.backgroundColor = ColorRandom;
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitleLabel.textAlignment = NSTextAlignmentLeft;
        subTitleLabel.font = [UIFont systemFontOfSize:15.f];
        subTitleLabel.textColor = [UIColor grayColor];;
        subTitleLabel.adjustsFontSizeToFitWidth = YES;
        subTitleLabel.numberOfLines = 0;
        [self.contentView addSubview:subTitleLabel];
        //detailLabel.backgroundColor = ColorRandom;
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont systemFontOfSize:15.f];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.adjustsFontSizeToFitWidth = YES;
        contentLabel.textAlignment = NSTextAlignmentRight;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        //detailLabel.backgroundColor = ColorRandom;
        
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectZero;
        [deleteButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [deleteButton addTarget:self action:@selector(deleteDataFromArray:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteButton];
        
        line = [CALayer layer];
        [line setFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        [line setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8].CGColor];
        [self.contentView.layer addSublayer:line];
        
    }
    return self;
}

- (void)deleteDataFromArray:(id)sender {
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(sheetTablewViewCell:deleteData:)]) {
        [self.cellDelegate sheetTablewViewCell:self deleteData:sender];
    }
}

- (void)setObject:(id)object {
    
    if([object isKindOfClass:[SheetViewDataModel class]]) {
        SheetViewDataModel *item = (SheetViewDataModel *)object;
        titleLabel.text     = item.title ?: @"";
        subTitleLabel.text  = item.subTitle ?: @"";
        contentLabel.text   = item.content ?: @"";
    }
}

- (void)totalCount:(NSInteger)totalCount currentIndex:(NSInteger)index {
    if (index == totalCount - 1) {
        [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else {
        [deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    titleLabel.frame    = CGRectMake(leftPadding, 0, 50.f, cellHeight);
    subTitleLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10,
                                     0,
                                     mainScreenWidth/2 - leftPadding - 10 - CGRectGetWidth(titleLabel.frame),
                                     cellHeight);
    deleteButton.frame  = CGRectMake(self.frame.size.width - 40 - leftPadding, (cellHeight - 40)/2, 40, 40);
    contentLabel.frame  = CGRectMake(mainScreenWidth/2 + 10,
                                     0,
                                     mainScreenWidth/2 - 10 - leftPadding - CGRectGetWidth(deleteButton.frame) - 10,
                                     cellHeight);
    line.frame          = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}



@end
