//
//  SingleRowPickerView.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView
<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) void (^pickerChangedValue)(NSInteger component, NSInteger row);//改变选择器内容
@property (nonatomic,strong) UIPickerView   *pickerView;//主体的picker
@property (nonatomic,strong) NSMutableArray *dataSource;//数据源
@property (nonatomic,assign) BOOL           isSingleRow;//是不是单列

//实例化View与相关控件
- (void)makeView;
//隐藏view
- (void)hiddenView:(BOOL)refresh;
//显示view
- (void)showView;
//刷新所有行
- (void)refreshAllComponent;
//刷新单行
- (void)refreshComponent:(NSInteger)component;
//获某列选中的行
- (NSInteger)getSelectedRowInComponent:(NSInteger)component;

@end
