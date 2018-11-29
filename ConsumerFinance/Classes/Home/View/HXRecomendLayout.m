//
//  HXRecomendLayout.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXRecomendLayout.h"

@implementation HXRecomendLayout
//特殊必须重写父类方法

//获得属性数组

-(void)prepareLayout{
    
    [super prepareLayout];
    array = [[NSMutableArray alloc] init];
    //获得一共有多少张图片
    //在第几个setion里面有几张图片
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //获得collectionView的中心点
    
    
//    UICollectionViewLayoutAttributes * layout = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
//    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
//    
//    [array addObject:layout];
    //为 每个item赋值
    for (int i=0; i<count; i++) {
        //获得要修改的属性
        //创建indexPath 第0个section里面对应每个i值
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //当图片宽度不定的时候
        att.frame = CGRectMake(12+140*indexPath.row, 0, 130, 226);
        
        [array addObject:att];
        
        
    }
    
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
  
    return CGSizeMake(12+140*cellCount,226);
    
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

@interface HXLikeLayout()
@end
@implementation HXLikeLayout
//特殊必须重写父类方法

//获得属性数组

-(void)prepareLayout{
    
    [super prepareLayout];
    array = [[NSMutableArray alloc] init];
    //获得一共有多少张图片
    //在第几个setion里面有几张图片
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //获得collectionView的中心点
    
    
    //    UICollectionViewLayoutAttributes * layout = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    //    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    //
    //    [array addObject:layout];
    //为 每个item赋值
    for (int i=0; i<count; i++) {
        //获得要修改的属性
        //创建indexPath 第0个section里面对应每个i值
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //当图片宽度不定的时候
        att.frame = CGRectMake(12+140*indexPath.row, 0, 130, 201);
        
        [array addObject:att];
        
        
    }
    
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    return CGSizeMake(12+140*cellCount,201);
    
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
@end;
