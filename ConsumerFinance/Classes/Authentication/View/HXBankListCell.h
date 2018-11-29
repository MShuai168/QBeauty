//
//  HXBankListCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/21.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXBankListModel.h"
@protocol HXBankDelegate;
@interface HXBankListCell : BaseTableViewCell
@property (nonatomic,strong)NSIndexPath * index;
@property (nonatomic,assign)id<HXBankDelegate>delegate;
@property (nonatomic,strong)HXBankListModel * model;
@end
@protocol HXBankDelegate <NSObject>

-(void)delegateCell:(NSIndexPath *)indexpath;

@end
