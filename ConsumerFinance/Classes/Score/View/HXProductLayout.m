//
//  HXProductLayout.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXProductLayout.h"
@implementation HXProductLayout
//特殊必须重写父类方法

//获得属性数组

-(void)prepareLayout{
    
    [super prepareLayout];
    array = [[NSMutableArray alloc] init];
    //获得一共有多少张图片
    //在第几个setion里面有几张图片
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //获得collectionView的中心点
    
    
    UICollectionViewLayoutAttributes * layout = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    
    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, 48);

    [array addObject:layout];
    //为 每个item赋值
    for (int i=0; i<count; i++) {
        //获得要修改的属性
        //创建indexPath 第0个section里面对应每个i值
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(12+((SCREEN_WIDTH-34)/2+10)*(int)(indexPath.row%2), 48+(11+245+(SCREEN_WIDTH-34)/2-129)*(int)(indexPath.row/2), (SCREEN_WIDTH-34)/2, 245+(SCREEN_WIDTH-34)/2-129);
        [array addObject:att];
    }
    
    
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if(cellCount==0){
        if ([self.delegate respondsToSelector:@selector(updateHeight:)]) {
            [self.delegate updateHeight:0]
            ;
        }
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
    if ([self.delegate respondsToSelector:@selector(updateHeight:)]) {
        [self.delegate updateHeight:(int)((cellCount-1)/2) *(256+(SCREEN_WIDTH-34)/2-129)+10+(245+(SCREEN_WIDTH-34)/2-129)+48]
        ;    }
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 48+245+(SCREEN_WIDTH-34)/2-129+(int)((cellCount-1)/2)*(256+(SCREEN_WIDTH-34)/2-129)+10);
    
}

//真正布局的方法

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [array objectAtIndex:indexPath.row];
    
    
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    
    return array;
    
    
    
}
@end
