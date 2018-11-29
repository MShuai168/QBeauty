//
//  HomeDetailViewController.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailViewController : UIViewController
//当前位置的经纬度
@property (nonatomic, assign) CGFloat latitude;//纬度
@property (nonatomic, assign) CGFloat longitude;//经度
@property (nonatomic, assign) int id; //门店ID
@end
