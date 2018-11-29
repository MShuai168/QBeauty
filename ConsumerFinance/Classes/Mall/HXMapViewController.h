//
//  HXMapViewController.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/29.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface HXMapViewController : UIViewController
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)NSString * titleName;
@property (nonatomic,strong)NSString * companyAddress;
@end
