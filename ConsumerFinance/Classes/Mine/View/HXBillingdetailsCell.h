//
//  HXBillingdetailsCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/16.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXBillDetailsModel.h"
@protocol billdetailDelegate;
@interface HXBillingdetailsCell : BaseTableViewCell
@property (nonatomic,strong)UIView * topLine;
@property (nonatomic,strong)UIView * botLine;
@property (nonatomic,strong)UIButton * photoImage;
@property (nonatomic,strong)HXBillDetailsModel * model;
@property(nonatomic,strong)NSIndexPath * index;
@property (nonatomic,assign)id<billdetailDelegate>delegate;
@end
@protocol billdetailDelegate <NSObject>

-(void)selectAction:(NSIndexPath *)index;

@end
