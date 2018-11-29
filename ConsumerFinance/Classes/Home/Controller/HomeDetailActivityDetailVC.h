//
//  HomeDetailActivityVC.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnBlock)(NSString *str);

@interface HomeDetailActivityDetailVC : UIViewController
@property (nonatomic, assign) int id;  //活动id
@property (nonatomic, copy) returnBlock block;
@end
