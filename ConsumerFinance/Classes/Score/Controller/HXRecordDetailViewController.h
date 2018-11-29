//
//  HXRecordDetailViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXRecordDetaiViewModel.h"
#import "HXRecordModel.h"
@protocol RecordDetailDelegate;
@interface HXRecordDetailViewController : UIViewController
@property (nonatomic,strong)HXRecordDetaiViewModel * viewModel;
@property (nonatomic,weak)id<RecordDetailDelegate>delegate;
@end
@protocol RecordDetailDelegate <NSObject>
-(void)updateCancelStates:(HXRecordModel *)model;
@end
