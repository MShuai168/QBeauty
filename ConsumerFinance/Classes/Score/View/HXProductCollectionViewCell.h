//
//  HXProductCollectionViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/7.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXShopCarModel.h"
@protocol productCollectDelegate;
@interface HXProductCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)BOOL shoopBool; //购物车是否存在 YES存在
@property (nonatomic,strong)HXShopCarModel * model;
@property (nonatomic,weak)id<productCollectDelegate>delegate;
@end
@protocol productCollectDelegate <NSObject>

-(void)changeShopCart:(HXShopCarModel *)model;

@end
