//
//  HXChangePassWordViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/6/29.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXBaseViewModel.h"

@interface HXChangePassWordViewModel : HXBaseViewModel
@property (nonatomic,strong)NSString * oldPassWord;
@property (nonatomic,strong)NSString * firstPassWord;
@property (nonatomic,strong)NSString * secondPassWord;
-(void)submitPassWordWithReturnBlock:(ReturnValueBlock)returnBlock;
@end
