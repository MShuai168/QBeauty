//
//  HXIdCardVerificationViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/26.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXIdCardVerificationViewModel : HXBaseViewModel
-(void)submitIdCard:(NSString *)idcard returunBlock:(ReturnValueBlock)returunBlock;
@end
