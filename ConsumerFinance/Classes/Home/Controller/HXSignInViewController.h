//
//  HXSignInViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/8.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^signReturn)(void);

@interface HXSignInViewController : UIViewController

@property (nonatomic, strong) signReturn block;

- (void)dismiss;

@end
