//
//  AddressWithZonesPickView.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "AddressWithZonesPickView.h"
#import "FileManager.h"
#import "Helper.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 216.0f
#define buttonWidth 60.0f

@interface AddressWithZonesPickView()

@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *zoneArray;
@property (nonatomic, strong) UIView *bottomView;//包括导航视图和地址选择视图
@property (nonatomic, strong) UIPickerView *pickView;//地址选择视图
@property (nonatomic, strong) UIView *navigationView;//上面的导航视图

@property (nonatomic, strong) NSMutableArray *addresses;
@property (nonatomic, assign) BOOL animate;

@end

@implementation AddressWithZonesPickView

+ (instancetype)shareInstanceWithAnimate:(BOOL)animate {
    static AddressWithZonesPickView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AddressWithZonesPickView alloc] initWithAnimate:animate];
    });
    if (animate) {
        [shareInstance showBottomView];
    }
    return shareInstance;
}

- (instancetype)initWithAnimate:(BOOL)animate {
    if (self == [super init]) {
        _provinceArray = [NSMutableArray array];
        _cityArray = [NSMutableArray array];
        _zoneArray = [NSMutableArray array];
        
        _animate = animate;
        
        if (animate) {
            self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            [self _addTapGestureRecognizerToSelf];
        }
        
        [self _getPickerData];
        [self _createView];
    }
    return self;
}

#pragma mark - get data

- (void)_getPickerData {
    id object = [[FileManager manager] getObjectFromTxtWithFileName:@"areaZones"];
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        NSArray *items = (NSArray *)object[@"data"];
        
        self.addresses = [AddressModel mj_objectArrayWithKeyValuesArray:items];
        
        _provinceArray = self.addresses;
        
        [self _paddingData:0 cityRow:0];
    }
    
}

- (void)_paddingData:(NSInteger)provinceRow cityRow:(NSInteger)cityRow {
    [_cityArray removeAllObjects];
    [_zoneArray removeAllObjects];
    
    AddressModel *provinceModel = [_provinceArray objectAtIndex:provinceRow];
    if (provinceModel) {
        [_cityArray addObjectsFromArray:provinceModel.zones];
    }
    
    AddressModel *cityModel = [_cityArray objectAtIndex:cityRow];
    if (cityModel) {
        [_zoneArray addObjectsFromArray:cityModel.zones];
    }
}

- (void)_addTapGestureRecognizerToSelf {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}

- (void)_createView {
//    kScreenHeight-navigationViewHeight-pickViewViewHeight
    //kScreenHeight
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-navigationViewHeight-pickViewViewHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.userInteractionEnabled = YES;
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = 100 + i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
}

- (void)tapButton:(UIButton*)button {
    
    //点击确定回调block
    if (button.tag == 101) {
        
        NSInteger provinceIndex = [_pickView selectedRowInComponent:0];
        NSInteger cityIndex     = [_pickView selectedRowInComponent:1];
        NSInteger zoneIndex = [_pickView selectedRowInComponent:2];
        
        AddressModel *provinceModel = self.addresses[provinceIndex];
        AddressModel *cityModel = cityModel = [self.cityArray objectAtIndex:cityIndex];
        AddressModel *zoneModel = nil;
        if (self.zoneArray.count > 0) {
            zoneModel = [self.zoneArray objectAtIndex:zoneIndex];
        }
        
        
        if (self.block) self.block (provinceModel, cityModel, zoneModel);
    }
    if (self.animate) {
        [self hiddenBottomView];
    }
    if (self.dismiss) {
        self.dismiss();
    }
}

-(void)showBottomView {
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        
        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight-64;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hiddenBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

//判断pickerview是否正在滚动
- (bool) anySubViewScrolling:(UIView*)view {
    if( [ view isKindOfClass:[ UIScrollView class ] ] )
    {
        UIScrollView* scroll_view = (UIScrollView*) view;
        if( scroll_view.dragging || scroll_view.decelerating )
        {
            return true;
        }
    }
    
    for( UIView *sub_view in [ view subviews ] )
    {
        if( [ self anySubViewScrolling:sub_view ] )
        {
            return true;
        }
    }
    return false;
}

#pragma mark - UIPicker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = _provinceArray.count;
        break;
        case 1:
            count = _cityArray.count;
        break;
        case 2:
            count = _zoneArray.count;
        break;
        
        default:
        break;
    }
    return count;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *lable = [[UILabel alloc] init];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:16.0f];
    
    switch (component) {
        case 0: {
            AddressModel *model = [self.provinceArray objectAtIndex:row];
            lable.text = model.areaName;
        }
        break;
        case 1: {
            AddressModel *model = [self.cityArray objectAtIndex:row];
            lable.text = model.areaName;
        }
        break;
        case 2: {
            AddressModel *model = [self.zoneArray objectAtIndex:row];
            lable.text = model.areaName;
        }
        break;
        
        default:
        break;
    }
    
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat pickViewWidth = kScreenWidth/3;
    
    return pickViewWidth;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [self _paddingData:row cityRow:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    
    if (component == 1) {
        [self _paddingData:[pickerView selectedRowInComponent:0] cityRow:row];
        [pickerView reloadComponent:2];
    }
    
}

@end
