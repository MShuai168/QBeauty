//
//  HXRecordTableViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/21.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXRecordModel.h"
@protocol RecordDelegate;
@interface HXRecordTableViewCell : BaseTableViewCell
//@property (nonatomic,assign)ShopStates states; //商品状态
@property (nonatomic,strong)HXRecordModel * model;
@property (nonatomic,weak)id<RecordDelegate>delegate;
@end
@protocol RecordDelegate<NSObject>
-(void)changeRecordData:(HXRecordModel *)model;
@end
