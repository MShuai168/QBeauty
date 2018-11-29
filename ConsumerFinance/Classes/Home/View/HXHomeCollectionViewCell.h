//
//  HXHomeCollectionViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/9.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXStarView.h"

#import "HXHomeCollectionViewCellViewModel.h"

@interface HXHomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HXHomeCollectionViewCellViewModel *viewModel;
@property (nonatomic, strong) HXStarView *starView;

@end
