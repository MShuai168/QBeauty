//
//  HXCommentCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXCommentModel.h"
@protocol hxcommentDelegate;
@interface HXCommentCell : BaseTableViewCell
@property (nonatomic,strong)HXCommentModel * hxcModel;
@property (nonatomic,assign)id<hxcommentDelegate>delegate;
@end
@protocol hxcommentDelegate <NSObject>

-(void)updateTableViewHeight;

@end
