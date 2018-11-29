//
//  RelateView.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/7/26.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedButtonBlock)(UIButton *button);

@interface RelateView : UIView

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, copy) selectedButtonBlock selectedButton;

@end
