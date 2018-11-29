//
//  HXTextField.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2018/1/9.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTextField;
typedef void(^deleteKeyReturn)(HXTextField *field);

@interface HXTextField : UITextField

@property (nonatomic, strong) deleteKeyReturn deleteKeyReturnBlock;

@end
