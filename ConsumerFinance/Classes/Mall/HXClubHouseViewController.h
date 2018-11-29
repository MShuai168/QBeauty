//
//  HXClubHouseViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXClubHouseViewModel.h"
@interface HXClubHouseViewController : UIViewController
@property (nonatomic,strong) HXClubHouseViewModel * viewModel;
@property (nonatomic,strong) NSString * titleName;
@end
