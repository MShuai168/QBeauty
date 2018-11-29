//
//  HXWeddingdetailViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDetailsViewModel.h"

@interface HXWeddingdetailViewController : UIViewController
@property (nonatomic,assign)BOOL weddingBool ; //判断是否为婚宴
@property (nonatomic,strong)HXDetailsViewModel * viewModel;
@end
