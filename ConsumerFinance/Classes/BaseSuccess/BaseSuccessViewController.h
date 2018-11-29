//
//  BaseSuccessViewController.h
//  creditor
//
//  Created by Jney on 16/9/6.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSuccessViewController : UIViewController
@property (nonatomic,strong) UILabel *showLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *iconImg;


- (void) jumpVC;

@end
