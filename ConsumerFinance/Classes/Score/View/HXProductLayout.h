//
//  HXProductLayout.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/6.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol productDelegate;
@interface HXProductLayout : UICollectionViewFlowLayout

{
    
    
    NSMutableArray * array ;
}
@property (nonatomic,assign)id<productDelegate>delegate;
@end
@protocol productDelegate <NSObject>

-(void)updateHeight:(NSInteger)height;
@end
