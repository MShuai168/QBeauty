//
//  PopupView.m
//  买布易
//
//  Created by 张建 on 15/6/26.
//  Copyright (c) 2015年 张建. All rights reserved.
//

#import "AddressPickView.h"
#import "FileManager.h"
#import "Helper.h"


#define navigationViewHeight 44.0f
#define pickViewViewHeight 216.0f
#define buttonWidth 60.0f

@interface AddressPickView ()

@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图


@property (nonatomic, strong) NSMutableArray *addresses;

@end

@implementation AddressPickView
+ (instancetype)shareInstance
{
    static AddressPickView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AddressPickView alloc] init];
    });
    
    [shareInstance showBottomView];
    return shareInstance;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        
        _provinceArray = [NSMutableArray array];
        _cityArray = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self _addTapGestureRecognizerToSelf];
        [self _getPickerData];
        [self _createView];
        
    }
    return self;
  
}

#pragma mark - get data
- (void)_getPickerData
{
    id object = [[FileManager manager] getObjectFromTxtWithFileName:@"area"];
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        NSArray *items = (NSArray *)object[@"data"];
        
        self.addresses = [AddressModel mj_objectArrayWithKeyValuesArray:items];
        
        for (AddressModel *item in self.addresses) {
            [_provinceArray addObject:item.areaName ? item.areaName : @""];
        }
        
        AddressModel *provinceModel = self.addresses[0];
        
        for (AddressModel *item in provinceModel.zones) {
            [_cityArray addObject:item.areaName ? item.areaName : @""];
        }
        
    }

}
-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}

- (void)_createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
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
-(void)tapButton:(UIButton*)button
{
    
    //点击确定回调block
    if (button.tag == 101) {

        NSInteger provinceIndex = [_pickView selectedRowInComponent:0];
        NSInteger cityIndex     = [_pickView selectedRowInComponent:1];
        
        AddressModel *provinceModel = self.addresses[provinceIndex];
        AddressModel *cityModel     = (provinceModel.zones.count > cityIndex) ? provinceModel.zones[cityIndex] : nil;
        
        if (self.block) self.block (provinceModel, cityModel);
    }
    
    [self hiddenBottomView];

    
}
-(void)showBottomView
{
    
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        
        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight-64;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {

    }];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
//判断pickerview是否正在滚动
- (bool) anySubViewScrolling:(UIView*)view
{
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
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArray.count;
    }else {
        return _cityArray.count;
    }
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lable = [[UILabel alloc] init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:16.0f];
    if (component == 0) {
        lable.text = [self.provinceArray objectAtIndex:row];
    }else {
        lable.text = [self.cityArray objectAtIndex:row];
    }
    //if ([self anySubViewScrolling:pickerView]) {
        //((UIButton *)[self viewWithTag:101]).enabled = NO;
        //self.superview.userInteractionEnabled = NO;
    //}
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat pickViewWidth = kScreenWidth/2;

    return pickViewWidth;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
    
        AddressModel *model = self.addresses[row];

        if (model.zones.count > 0) {
            [self.cityArray removeAllObjects];
            for (AddressModel *item in model.zones) {
                [self.cityArray addObject:item.areaName ? item.areaName : @""];
            }
        } else {
            [self.cityArray removeAllObjects];
        }
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
    }
    //((UIButton *)[self viewWithTag:101]).enabled = YES;
    //self.superview.userInteractionEnabled = YES;
 
}


@end
