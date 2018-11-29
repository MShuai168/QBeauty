//
//  HXSearchViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/24.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSearchViewModel.h"
#import "LetterListModel.h"
@interface HXSearchViewController : UIViewController
@property (nonatomic, strong) LetterListModel * letterModel; //城市ID
@property (nonatomic, strong) HXSearchViewModel * viewModel;
@end
