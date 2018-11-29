//
//  HXSelectTableView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/12.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXSelectTableView.h"
#define CC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define cellHeight 50
@interface HXSelectTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}
@property (nonatomic, strong) UIWindow *sheetWindow;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSArray * selectArray;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) void (^selctBlock)();
@end
@implementation HXSelectTableView
+ (instancetype)shareSheet{
    static id shareSheet;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareSheet = [[[self class] alloc] init];
    });
    return shareSheet;
}
- (void)hx_selectTableWithSelectArray:(NSArray *)array title:(NSString *)title select:(void (^)())selectBlock {
    self.title = title;
    self.selectArray = [NSArray arrayWithArray:array];
    self.selctBlock = selectBlock;
    if (!_sheetWindow) {
        [self initSheetWindow];
    }
    _sheetWindow.hidden = NO;
    
    [self showSheetWithAnimation];
    
    
}
-(void)display {
    CGFloat viewHeight;
    if (self.selectArray.count>=8) {
        viewHeight = cellHeight * 9;
    }else {
        viewHeight = cellHeight * (self.selectArray.count+1);
    }
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    [_sheetWindow addSubview:_tableView];
    if (self.selectArray.count>8) {
        _tableView.scrollEnabled = YES;
    }else {
        _tableView.scrollEnabled = NO;
    }
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = kUIColorFromRGB(0xf2f4f5);
    _tableView.tableHeaderView = headView;
    
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.text = self.title;
    nameLabel.textColor = ComonTextColor;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(15);
        make.center.equalTo(headView);
    }];
   
}
- (void)initSheetWindow{
    _sheetWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, CC_SCREEN_WIDTH, CC_SCREEN_HEIGHT)];
    _sheetWindow.windowLevel = UIWindowLevelStatusBar;
    _sheetWindow.backgroundColor = [UIColor clearColor];
    
    _sheetWindow.hidden = YES;
    
    _backView = [[UIView alloc] initWithFrame:_sheetWindow.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.0;
    [_sheetWindow addSubview:_backView];
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    _tapGesture.numberOfTapsRequired = 1;
    [_backView addGestureRecognizer:_tapGesture];
    
    
    [self display];
}
#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        [cell creatLine:15 hidden:NO];
        cell.nameLabel.text = [self.selectArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selctBlock([self.selectArray objectAtIndex:indexPath.row]);
    [self hidSheetWithAnimation];
}
- (void)showSheetWithAnimation{
    CGFloat viewHeight;
    if (self.selectArray.count>=8) {
        viewHeight = cellHeight * 9;
    }else {
        viewHeight = cellHeight * (self.selectArray.count+1);
    }

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _tableView.frame = CGRectMake(0, CC_SCREEN_HEIGHT - viewHeight, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.2;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hidSheetWithAnimation{
    CGFloat viewHeight;
    if (self.selectArray.count>=8) {
        viewHeight = cellHeight * 9;
    }else {
        viewHeight = cellHeight * (self.selectArray.count+1);
    }

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _tableView.frame = CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self hidActionSheet];
    }];
}
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self hidSheetWithAnimation];
}
- (void)hidActionSheet{
    _sheetWindow.hidden = YES;
    _sheetWindow = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
