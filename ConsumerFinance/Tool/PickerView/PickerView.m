//
//  SingleRowPickerView.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "PickerView.h"


#define PickerHeight    216.0f
#define ToolBarHeight   40.0f

@interface PickerView ()
@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, assign) NSInteger selectComponent;
@end


@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}


- (void)makeView{
    
    self.backgroundColor = [COLOR_DEFAULT_BLACK colorWithAlphaComponent:0.2];
    self.alpha           = 0;
    self.selectRow       = 0;
    self.selectComponent = 0;
    
    //点击空白取消选择器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(hiddenView:)];//单击手势
    [self addGestureRecognizer:tap];
    
    //时间选择器
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                     self.height-PickerHeight,
                                                                     self.width,
                                                                     PickerHeight)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = NO;//显示选择目标
    [self addSubview:self.pickerView];
    
    //功能条
    [self makeToolView];
}

#pragma mark 做功能条
- (void)makeToolView{
    //托底条
    UIView *toolView=[[UIView alloc] init];
    toolView.backgroundColor = HXRGB(242, 242, 242);
    toolView.frame = CGRectMake(0,
                                self.height-_pickerView.height-ToolBarHeight,
                                SCREEN_WIDTH,
                                ToolBarHeight);
    //取消按钮
    UIButton *btnL = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnL setTitle:@"取消" forState:UIControlStateNormal];
    btnL.titleLabel.font = NormalFontWithSize(16.0+fontScale);
    btnL.frame = CGRectMake(5*displayScale,
                            0,
                            50*displayScale,
                            ToolBarHeight);
    [btnL addTarget:self action:@selector(hiddenView:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:btnL];
    
    //确认按钮
    UIButton *btnR = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnR setTitle:@"确定" forState:UIControlStateNormal];
    btnR.titleLabel.font = NormalFontWithSize(16.0+fontScale);
    btnR.frame = CGRectMake(toolView.width-55*displayScale,
                            0,
                            50*displayScale,
                            ToolBarHeight);
    [btnR addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:btnR];
    
    [self addSubview:toolView];
}


//取消
- (void)hiddenView:(BOOL)refresh{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
        if (finished && refresh) {
            [self getPickerSelectConment];
        }
    }];
}

//显示选择器
- (void)showView{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

//确定
- (void)doneClick{
    
    [self hiddenView:YES];
    
   //[self getPickerSelectConment];
    
}

//刷新所有行
- (void)refreshAllComponent {
    [self.pickerView reloadAllComponents];
}

//刷新单行
- (void)refreshComponent:(NSInteger)component {
    [self.pickerView reloadComponent:component];
}

- (NSInteger)getSelectedRowInComponent:(NSInteger)component{
    return [self.pickerView selectedRowInComponent:component];
}



#pragma mark - UIPickerViewDataSource
/**
 *  设置列数（必须要实现的代理方法）
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.isSingleRow ? 1 : _dataSource.count;
}

/**
 *  每列多少行（必须要实现的代理方法）
 *  component:第几列
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.isSingleRow ? [_dataSource count] : [_dataSource[component] count];
}

#pragma mark - UIPickerViewDelegate
/**
 *  行高
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44*displayScale;
}

/**
 *  获取到数据源中的数据，展示到pickerView上
 *  component:第几列
 *  row:第几行
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.isSingleRow ? _dataSource[row] : _dataSource[component][row];
}

/**
 *  当每次停止滚动，走这个代理。
 *  component:第几列
 *  row:第几行
 */
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectComponent = component;
    self.selectRow       = self.isSingleRow ? row : [_pickerView selectedRowInComponent:component];
    //[self getPickerSelectConent];
}


/**
 *  返回的是每个选项的view
 *  如果需要改变选择文字的字体、字号、颜色等可以选用此代理
 *  component:第几列
 *  row:第几行
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = COLOR_BLACK_DARK;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = NormalFontWithSize(16.0+fontScale);
    id value = self.isSingleRow ? _dataSource[row] : _dataSource[component][row];
    if ([value isKindOfClass:[NSString class]]) {
        lab.text = value;
    } else {
        lab.text = [value stringValue];
    }
    return lab;
}


#pragma mark 获取选择器当前滚动列选中的行
- (void) getPickerSelectConment{
    
    if(self.pickerChangedValue){
        self.pickerChangedValue(self.selectComponent, self.selectRow);
    }
}



@end
