//
//  HXSetTradePWDViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXSetTradePWDViewModel : HXBaseViewModel
-(void)submitPassWord:(NSString *)passWord returunBlock:(ReturnValueBlock)returunBlock;
@end
