//
//  SelectPhotoView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
@interface SelectPhotoView : UIScrollView
{
    //可见视图集合
    NSMutableSet *_visibleCells;
    //不可见视图集合
    NSMutableSet *_recycledCells;
    ImageCell * _currentCell;
    
}
@property (nonatomic,assign) NSInteger index; //选图的下标
@property (nonatomic,strong) void (^selectDeselect)();
// 根据下标设置对应的frame、index、text

- (void)configureCell:(ImageCell *)cell forIndex:(NSUInteger)index;

// 判断index对应的视图是否在可见队列中

- (BOOL)isVisibleCellForIndex:(NSUInteger)index;

// 重用

- (id)dequeueReusableCell;

// 显示文本

- (void)showCells;
-(id)initWithDataArr:(NSMutableArray *)dataArr;
@end
