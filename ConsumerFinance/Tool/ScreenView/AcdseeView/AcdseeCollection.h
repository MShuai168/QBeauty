//
//  AcdseeCollection.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcdseeCollection : UIView
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray * imageArr;
-(void)creatCollectionview;
-(void)creatSectionCollection:(float)height;
@end
