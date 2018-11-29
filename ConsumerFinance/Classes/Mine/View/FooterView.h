//
//  FooterView.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/5/22.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalPricesLabel;  //商品总价
@property (weak, nonatomic) IBOutlet UILabel *discountLabel; //totalDiscount总折扣
@property (weak, nonatomic) IBOutlet UILabel *couponNameTemp;
@property (weak, nonatomic) IBOutlet UILabel *couponMoneyTemp;
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;  //优惠券名称
@property (weak, nonatomic) IBOutlet UILabel *couponMoneyLabel; //优惠金额
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;  //应收距离顶部的距离
@property (weak, nonatomic) IBOutlet UILabel *receivableLabel;   //应收
@property (weak, nonatomic) IBOutlet UILabel *paidMoneyLabel;  //实付
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLabel;  //门庭订单编号
@property (weak, nonatomic) IBOutlet UILabel *createLabel; //订单创建时间
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel; //支付方式1 + 金额
@property (weak, nonatomic) IBOutlet UILabel *payTypeName2Label;  //支付方式2 + 金额
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tempHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *tkFeeTemp;
@property (weak, nonatomic) IBOutlet UILabel *tkFeeLabel; //退款金额


@end
