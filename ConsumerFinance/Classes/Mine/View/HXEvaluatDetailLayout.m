//
//  HXEvaluatDetailLayout.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXEvaluatDetailLayout.h"

@implementation HXEvaluatDetailLayout
//特殊必须重写父类方法

//获得属性数组

-(void)prepareLayout{
    
    [super prepareLayout];
    array = [[NSMutableArray alloc] init];
    //获得一共有多少张图片
    //在第几个setion里面有几张图片
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //获得collectionView的中心点
    
    
    
    //为 每个item赋值
    for (int i=0; i<count; i++) {
        //获得要修改的属性
        //创建indexPath 第0个section里面对应每个i值
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //当图片宽度不定的时候
        att.frame = CGRectMake(15+((SCREEN_WIDTH-35)/4+5)*(int)(indexPath.row%4), 5+85*(int)(indexPath.row/4), (SCREEN_WIDTH-35)/4, 85);
        
//        att.frame = CGRectMake(15+(((SCREEN_WIDTH-20)-85*4)/3+85)*(i%4), 5+85*(int)(indexPath.row/4), 85, 85);
        
        [array addObject:att];
        
        
    }
    
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
}
- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    if ([self.delegate respondsToSelector:@selector(updateHeight:)]) {
        [self.delegate updateHeight:(int)((cellCount-1)/4) *95+10+95]
        ;    }

    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 95+(int)((cellCount-1)/4) *95+10);

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
