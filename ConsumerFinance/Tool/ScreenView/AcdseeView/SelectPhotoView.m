//
//  SelectPhotoView.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "SelectPhotoView.h"
#import "ImageCell.h"
#import "AcdseeScro.h"
#define kCellSeparatePadding    20.0
@interface SelectPhotoView()<UIScrollViewDelegate>
@property (nonatomic,strong) AcdseeScro * scro;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end
@implementation SelectPhotoView
-(id)initWithDataArr:(NSMutableArray *)dataArr {
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
        _visibleCells = [[NSMutableSet alloc] init];
        _recycledCells = [[NSMutableSet alloc] init];
        
        self.dataSource = dataArr;
        [self creatUI];
    }
    return self;
}
-(void)creatUI {
    AcdseeScro * scro = [[AcdseeScro alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH+20, SCREEN_HEIGHT)];
    self.scro = scro;
    [scro setBackgroundColor:[UIColor blackColor]];
    scro.delegate = self;
    [self addSubview:scro];
    [scro setPagingEnabled:YES];//激活翻页效果 滑动照片的时候不停在中间
    [scro setContentSize:CGSizeMake((SCREEN_WIDTH+20)*_dataSource.count, self.frame.size.height)];
    //不显示滚动条
    [scro setShowsHorizontalScrollIndicator:NO];
    [scro setShowsVerticalScrollIndicator:NO];
    [self showCells];
    
    
}
-(void)setIndex:(NSInteger)index {
    
    [self.scro setContentOffset:CGPointMake(index*(SCREEN_WIDTH+20), 0)];
}
//图片
- (void)configureCell:(ImageCell *)cell forIndex:(NSUInteger)index{
    // 设置index
    
    
    cell.index = index;
    
    CGFloat x = (kCellSeparatePadding + SCREEN_WIDTH) * index;
    
    CGFloat y = 0;
    
    CGFloat width = SCREEN_WIDTH;
    
    CGFloat height = SCREEN_HEIGHT;
    
    // 设置frame
    cell.frame = CGRectMake(x, y, width, height);
    
    //    NSNumber * imageWidth = [dic objectForKey:@"width"];
    //    NSNumber * imageHeight = [dic objectForKey:@"height"];
    //    // 设置显示图片大小和链接
    //    cell.imageSize = CGSizeMake([imageWidth floatValue], [imageHeight floatValue]);
    
    //    cell.imageUrl = [[_dataSource objectAtIndex:index] objectForKey:@"ImgUrl"];
    if ([[_dataSource objectAtIndex:index] isKindOfClass:[UIImage class]]) {
        cell.image = [_dataSource objectAtIndex:index];
        return;
    }
    cell.imageName = [_dataSource objectAtIndex:index];
}

// 判断index对应的视图是否在可见队列中
- (BOOL)isVisibleCellForIndex:(NSUInteger)index{
    
    BOOL isVisible = NO;
    
    for (ImageCell *cell in _visibleCells) {
        
        if (cell.index == index) {
            
            isVisible = YES;
            
            break;
            
        }
        
    }
    
    return isVisible;
    
}

// 重用
- (id)dequeueReusableCell{
    
    ImageCell *cell = [_recycledCells anyObject];      // retain count = 1;
    
    if (cell != nil) {
        
        //                [cell copy] ;                                    // retain count = 2 ,but it seems retain count = 1
        //
        [_recycledCells removeObject:cell];                       // retain count = 1 now and autorelease
        
    }
    
    return cell;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_dataSource count] > 0) {
        [self showCells];
        //判断是否翻页,如果翻页获取该页显示内容
        int width = SCREEN_WIDTH +20;
        if ((int)scrollView.contentOffset.x % width == 0
            && [scrollView class] == [UIScrollView class]) {
            [self getCurrentPage];
        }
    }
}
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

- (void)getCurrentPage
{
    // 当前UIScrollView的可见区域
    CGRect visibleBounds = _scro.bounds;
    // 获取当前页index
    int firstNeededCellIndex = floorf(CGRectGetMinX(visibleBounds) / (SCREEN_WIDTH + kCellSeparatePadding));
    firstNeededCellIndex = MAX(firstNeededCellIndex, 0);
    
    
    //还原不显示的页面的倍数
    NSArray * subViews = [_scro subviews];
    for (ImageCell * tempCell in subViews) {
        if (tempCell.index != firstNeededCellIndex) {
            [tempCell.imageView setFrame:CGRectMake(tempCell.imageView.frame.origin.x, tempCell.imageView.frame.origin.y, tempCell.imageView.frame.size.width * tempCell.zoomScale, tempCell.imageView.frame.size.height * tempCell.zoomScale)];
            [tempCell setZoomScale:1.0f];
            [tempCell setContentOffset:CGPointMake(0, 0)];
            [tempCell setContentSize:CGSizeMake(314, self.frame.size.height)];
        }else{
            //如果翻到新的一页
            if (_currentCell != tempCell) {
                _currentCell = tempCell;
            }
        }
    }
    
}

- (void)showCells{
    
    // 当前UIScrollView的可见区域
    
    CGRect visibleBounds = _scro.bounds;
    
    // 此处存在一定的误差
    
    int firstNeededCellIndex = floorf(CGRectGetMinX(visibleBounds) / (SCREEN_WIDTH + kCellSeparatePadding));
    
    long lastNeededICellIndex = floorf(CGRectGetMaxX(visibleBounds) / (SCREEN_WIDTH + kCellSeparatePadding));
    
    firstNeededCellIndex = MAX(firstNeededCellIndex, 0);
    
    lastNeededICellIndex  = MIN(lastNeededICellIndex, [_dataSource count] - 1);
    
    // 循环可见视图，将不在当前可见范围视图添加到循环队列中，然后从父视图中移除
    
    for (ImageCell * cell in _visibleCells) {
        
        if (cell.index < firstNeededCellIndex || cell.index > lastNeededICellIndex) {
            
            [_recycledCells addObject:cell];        // retain count + 1
            [cell removeFromSuperview];          // retain count - 1
        }
    }
    
    
    
    // 可见视图的集合减去循环队列的集合
    
    [_visibleCells minusSet:_recycledCells];
    
    
    // 添加缺少的cell
    
    for (int index = firstNeededCellIndex; index <= lastNeededICellIndex; index ++) {
        
        if (![self isVisibleCellForIndex:index]) {
            
            // 先取循环队列中寻找对应的数据
            
            ImageCell *cell = [self dequeueReusableCell];
            // 如果没有找到可用的，则创建一个新的
            
            if (cell == nil) {
                cell = [[ImageCell alloc] init] ;
                //给cell添加轻拍手势
                cell.userInteractionEnabled = YES;
                UITapGestureRecognizer * qingpai = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
                [cell addGestureRecognizer:qingpai];
                //                //设置放大缩小倍数
                //                [cell setMinimumZoomScale:0.5f];
                //                [cell setMaximumZoomScale:2.0f];
                cell.delegate = self;
            }
            
            // 设置下标、frame、text
            
            [self configureCell:cell forIndex:index];
            
            // 将其添加到视图中
            
            [_scro addSubview:cell];
            
            // 加入到可见队列中
            
            [_visibleCells addObject:cell];
            
            
        }
        
    }
    
}

-(void)tapAction
{
    _selectDeselect();
    
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
