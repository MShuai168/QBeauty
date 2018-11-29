//
//  HXMyViewLayout.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/11/10.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXMyViewLayout.h"

@implementation HXMyViewLayout
#pragma mark - cell的左右间距
- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    /* 处理左右间距 */
    for(int i = 1; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = 0;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}
@end
