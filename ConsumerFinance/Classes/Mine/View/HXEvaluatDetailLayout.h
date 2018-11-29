//
//  HXEvaluatDetailLayout.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol evaluatDetailDelegate;
@interface HXEvaluatDetailLayout : UICollectionViewFlowLayout
{
    
    
    NSMutableArray * array ;
}
@property (nonatomic,assign)id<evaluatDetailDelegate>delegate;
@end
@protocol evaluatDetailDelegate <NSObject>

-(void)updateHeight:(NSInteger)height;
    


@end
