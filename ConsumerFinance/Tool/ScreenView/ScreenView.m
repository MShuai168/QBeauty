//
//  ScreenView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "ScreenView.h"
#import "ComButton.h"
#import "HXBaseMenuView.h"
#import "HXItem.h"
#import "DistListModel.h"
#import "ScreenModel.h"
#import "TravelModel.h"
#define  ScrBtnTag 100
@interface ScreenView()
@property (nonatomic,assign) NSInteger screenNumber; //标记筛选按钮样式 2个/3个
@property (nonatomic,assign) NSInteger segIndex ; //标记 项目/医院
@property (nonatomic,strong) void (^selectCont)(); //筛选按钮响应block
@property (nonatomic,strong) UIView * screen; //顶部状态栏
@property (nonatomic,strong) NSMutableArray *symbolArray; //标记当前是否有菜单显示
@property (nonatomic,strong) NSMutableArray * screenbuttonArr; //存储筛选按钮
@property (nonatomic,strong) NSMutableArray * dataArr; //存储筛选数据
//标记第一组筛选数据
@property (nonatomic,strong) HXItem * firstItem;
@property (nonatomic,strong) HXItem * secondItem;
@property (nonatomic,strong) HXItem * thirdItem;

@property (nonatomic,strong)NSArray * firSelectArr;
@property (nonatomic,strong)NSArray * secondArr;
@property (nonatomic,strong)NSArray * thirdArr;
@end
@implementation ScreenView
-(id)initWithScreenNumber:(NSInteger)screenNumber segSelectIndex:(NSInteger)index selectContent:(void(^)())content{
    
    self = [super init];
    if (self) {
        self.screenNumber = screenNumber;
        self.segIndex = index;
        self.selectCont = content;
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    /**
     *  顶部筛选栏
     */
    UIView * screen = [[UIView alloc] init];
    self.screen = screen;
    screen.backgroundColor = kUIColorFromRGB(0xffffff);
    [self addSubview:screen];
    [screen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HXRGB(221, 221, 221);
    [screen addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(screen);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(screen).mas_offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    NSArray * nameArr;
    if (self.screenNumber == 2) {
        nameArr = @[@"全城",@"智能排序"];
        for (int i = 0; i<self.screenNumber; i++) {
            ScreenButton * button = [[ScreenButton alloc] init];
            button.nameLabel.text = [nameArr objectAtIndex:i];
            button.arrowimage.image = [UIImage imageNamed:@"xialajiantou1"];
            button.tag = ScrBtnTag+i;
            [button addTarget:self action:@selector(scrBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [screen addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(screen);
                make.left.equalTo(screen.mas_left).offset(SCREEN_WIDTH/self.screenNumber*i);
                make.width.mas_equalTo(SCREEN_WIDTH/self.screenNumber);
            }];
            [self.screenbuttonArr addObject:button];
            if (i==0) {
                UIView * line = [[UIView alloc] init];
                line.backgroundColor = kUIColorFromRGB(0xe6e6e6);
                [screen addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(screen);
                    make.centerY.equalTo(screen);
                    make.width.mas_equalTo(0.5);
                    make.top.equalTo(screen).offset(10);
                    make.bottom.equalTo(screen).offset(-10);
                }];
            }
        }
        
    }else
    {
        nameArr = @[@"全城",@"全部项目",@"智能排序"];
        for (int i = 0; i<self.screenNumber; i++) {
            ScreenButton * button = [[ScreenButton alloc] init];
            button.arrowimage.image = [UIImage imageNamed:@"xialajiantou1"];
            button.nameLabel.text = [nameArr objectAtIndex:i];
            button.tag = ScrBtnTag+i;
            [button addTarget:self action:@selector(scrBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [screen addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(screen);
                make.left.equalTo(screen.mas_left).offset(SCREEN_WIDTH/self.screenNumber*i);
                make.width.mas_equalTo(SCREEN_WIDTH/self.screenNumber);
            }];
            [self.screenbuttonArr addObject:button];
            if (i==2) {
                
            }else {
                UIView * line = [[UIView alloc] init];
                line.backgroundColor = kUIColorFromRGB(0xe6e6e6);
                [screen addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(screen.mas_left).offset(SCREEN_WIDTH/3*(i+1));
                    make.top.equalTo(screen).offset(10);
                    make.bottom.equalTo(screen).offset(-10);
                    make.width.mas_equalTo(0.5);
                }];
            }
        }
    }
}

#pragma mark --地区数据
-(void)areaData:(NSMutableArray *)dataArr {
    self.firSelectArr = dataArr;
    HXItem * item = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:@"全城"];
    for (int i = 0; i < dataArr.count+1; i++){
        if (i==0) {
            HXItem *item3_A = [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:@"全城"];
            [item addNode:item3_A];
            if (i==0) {
                item3_A.selected = YES;
            }
            //            NSArray * nameArr = @[@"附近",@"1km",@"3km",@"5km",@"10km",@"全城"];
            //            for (NSString * name in nameArr) {
            //                HXItem *item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:name];
            //                [item3_A addNode:item4_A];
            //                if ([name isEqualToString:@"全城"]) {
            //                    item4_A.selected = YES;
            //                }
            //            }
        }else {
            ScreenModel * model = [dataArr objectAtIndex:i-1];
            HXItem *item3_A = [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:model.cityName];
            [item addNode:item3_A];
            //            for (int j = 0; j < model.distList.count+1; j ++) {
            //                HXItem *item4_A;
            //                if (j == 0) {
            //                    item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:[NSString stringWithFormat:@"全部%@",model.cityName]];
            //                }else {
            //                    DistListModel * newModel = [model.distList objectAtIndex:j-1];
            //                    item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:newModel.name];
            //
            //                }
            //                [item3_A addNode:item4_A];
            //            }
        }
    }
    self.firstItem = item;
}

#pragma mark -- 排序数据
-(void)sortListData:(NSMutableArray *)dataArr {
    
    HXItem * item = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:@"智能排序"];
    int i = 0;
    for (ScreenModel * model in dataArr) {
        HXItem * item_one = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:model.name];
        [item addNode:item_one];
        if (i==0) {
            item_one.selected = YES;
        }
        i++;
    }
    if (self.screenNumber==2) {
        self.secondItem = item;
        self.secondArr = dataArr;
    }else {
        self.thirdItem = item;
        self.thirdArr = dataArr;
    }
    
    
}
-(void)projectData:(NSMutableArray *)dataArr {
    HXItem * item = [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:@"全部项目"];
    HXItem *item3_A = [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:@"全部项目"];
    [item addNode:item3_A];
    HXItem * item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:@"全部项目"];
    [item3_A addNode:item4_A];
    item3_A.selected = YES;
    item4_A.selected = YES;
    
    for (int i = 0; i < dataArr.count; i++){
        TravelModel * model = [dataArr objectAtIndex:i];
        HXItem *item3_A = [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:model.typeName];
        [item addNode:item3_A];
        for (int j = 0; j < model.childList.count+1; j ++) {
            HXItem *item4_A;
            if (j == 0) {
                item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:[NSString stringWithFormat:@"全部"]];
            }else {
                TravelModel * newModel = [model.childList objectAtIndex:j-1];
                item4_A =  [HXItem itemWithItemType:HXPopupViewMultilSeMultiSelection titleName:newModel.typeName];
            }
            [item3_A addNode:item4_A];
        }
    }
    self.secondItem = item;
    self.secondArr = dataArr;
}
#pragma mark -- 旅游数据
-(void)travelData:(NSMutableArray *)dataArr {
    HXItem * item = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:@"全城"];
    TravelModel * model = [[TravelModel  alloc] init];
    model.typeName = @"全城";
    model.id = @"";
    HXItem * item_one = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:model.typeName];
    [item addNode:item_one];
    item_one.selected = YES;
    for (TravelModel * model in dataArr) {
        HXItem * item_one = [HXItem itemWithItemType:HXPopupViewSingleSelection titleName:model.typeName];
        [item addNode:item_one];
    }
    self.firstItem = item;
    [dataArr insertObject:model atIndex:0];
    self.firSelectArr = dataArr;
}

#pragma mark -- 筛选按钮响应事件
-(void)scrBtnAction:(id)sender {
    ScreenButton * button = (ScreenButton *)sender;
    if (self.symbolArray.count) {
        //移除
        HXBaseMenuView * lastView = self.symbolArray[0];
        [lastView dismiss];
        lastView = nil;
        [self.symbolArray removeAllObjects];
        
        if (button.selected != YES) {
            [self creatMenu:button];
        }
    }else
    {
        [self creatMenu:button];
    }
    HXItem *item;
    switch (button.tag) {
        case ScrBtnTag:
        {
            item = self.firstItem;
        }
            break;
        case ScrBtnTag+1:
        {
            item = self.secondItem;
        }
            break;
        case ScrBtnTag+2:
        {
            item = self.thirdItem;
        }
            break;
            
        default:
            break;
    }
    if (!item) {
        return;
    }
    
    if (button.selected == YES) {
        //点击展开的按钮收回
        button.selected = NO;
        button.nameLabel.textColor = kUIColorFromRGB(0x666666);
        button.arrowimage.image = [UIImage imageNamed:@"xialajiantou1"];
    }else {
        
        [self changeButtonStates:button];
        
    }
}
#pragma mark -- 修改按钮状态
-(void)changeButtonStates:(ScreenButton *)scrbutton {
    for (ScreenButton * button in self.screenbuttonArr) {
        if (![scrbutton isEqual:button]) {
            button.selected = NO;
            button.nameLabel.textColor = kUIColorFromRGB(0x666666);
            button.arrowimage.image = [UIImage imageNamed:@"xialajiantou1"];
        }else {
            button.selected = YES;
            button.nameLabel.textColor = ComonBackColor;
            button.arrowimage.image = [UIImage imageNamed:@"xialajiantou2"];
        }
    }
}
#pragma mark -- 创建菜单栏
-(void)creatMenu:(ScreenButton *)button {
    HXItem *item;
    switch (button.tag) {
        case ScrBtnTag:
        {
            item = self.firstItem;
        }
            break;
        case ScrBtnTag+1:
        {
            item = self.secondItem;
        }
            break;
        case ScrBtnTag+2:
        {
            item = self.thirdItem;
        }
            break;
            
        default:
            break;
    }
    if (!item) {
        [self changeButtonStates:nil];
        [KeyWindow displayMessage:@"暂时没有筛选条件"];
        return;
    }
    HXBaseMenuView * hsmenu = [HXBaseMenuView getSubPopupView:item];
    hsmenu.selectItem = ^(NSString * title,NSInteger firstIndex,NSInteger secondIndex){
        if (title) {
            button.nameLabel.text = title;
            switch (button.tag) {
                case ScrBtnTag:
                {
                    if (self.travel) {
                        if (self.firSelectArr.count>=(firstIndex+1)) {
                            TravelModel * model = [self.firSelectArr objectAtIndex:firstIndex];
                            self.projectLeftid = model.id;
                        }else {
                            self.projectLeftid = @"";
                        }
                    }else {
                        //                        NSArray * distanceArr = @[@"500",@"1000",@"3000",@"5000",@"10000",@""];
                        if (firstIndex==0) {
                            //附近
                            //                            self.distance = [distanceArr objectAtIndex:secondIndex];
                            self.distance = @"";
                            self.areaId = @"";
                            self.distId = @"";
                        }else {
                            self.distance = @"";
                            if (self.firSelectArr.count>0 && self.firSelectArr.count>=firstIndex-1) {
                                ScreenModel * model = [self.firSelectArr objectAtIndex:firstIndex-1];
                                self.areaId = model.id;
                                self.distId = @"";
                                //                                if (secondIndex==0) {
                                //                                    self.distId = @"";
                                //                                }else {
                                //                                if (model.distList.count>secondIndex-1) {
                                //                                     DistListModel * newModel = [model.distList objectAtIndex:secondIndex-1];
                                //                                    self.distId = newModel.id;
                                //
                                //                                 }
                                //                              }
                            }
                            
                        }
                        
                    }
                    
                }
                    break;
                case ScrBtnTag+1:
                {
                    if (self.screenNumber == 3) {
                        //当3项此时为项目
                        //全部项目
                        if (secondIndex==0 && firstIndex==0) {
                            self.projectRightid = @"";
                            self.projectLeftid = @"";
                        }else {
                            if (self.secondArr.count!=0 && self.secondArr.count>=(firstIndex-1)) {
                                TravelModel * model = [self.secondArr objectAtIndex:firstIndex-1];
                                self.projectLeftid = model.id;
                                if (secondIndex!=0 &&model.childList.count>=secondIndex) {
                                    TravelModel * newModel = [model.childList objectAtIndex:secondIndex-1];
                                    self.projectRightid = newModel.id;
                                }else {
                                    self.projectRightid = @"";
                                }
                            }else {
                                self.projectRightid = @"";
                            }
                        }
                        
                    }else{
                        if (self.secondArr.count>=firstIndex+1) {
                            ScreenModel * model = [self.secondArr objectAtIndex:firstIndex];
                            self.sortFlg = model.id;
                        }else {
                            self.sortFlg = @"";
                        }
                        
                    }
                }
                    break;
                case ScrBtnTag+2:
                {
                    if (self.thirdArr.count>=firstIndex+1) {
                        ScreenModel * model = [self.thirdArr objectAtIndex:firstIndex];
                        self.sortFlg = model.id;
                    }else {
                        self.sortFlg = @"";
                    }
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            self.selectCont();// 回调刷新
        }
        button.selected = NO;
        [self changeButtonStates:nil];
    };
    [self addSubview:hsmenu];
    [hsmenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(40);
        make.right.and.left.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT-40);
    }];
    [hsmenu creatUI];
    [self.symbolArray addObject:hsmenu];
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
}
-(void)screenInformation {
    
    
    
    
    
}
#pragma mark -- setter
-(NSMutableArray *)symbolArray
{
    if (_symbolArray == nil) {
        _symbolArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _symbolArray;
}
-(NSMutableArray *)screenbuttonArr {
    if (_screenbuttonArr == nil) {
        _screenbuttonArr = [[NSMutableArray alloc] init];
    }
    return _screenbuttonArr;
}
-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _dataArr;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
