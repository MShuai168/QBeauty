//
//  HXPayView.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/10/12.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^successBlock)();
typedef void (^failBlock)();
@interface HXPayView : UIView
@property (nonatomic,strong)NSString * serviceCharge;
@property (nonatomic,strong)NSString * merchantOutOrderNo;
@property (nonatomic,assign)BOOL orderServiceBool;
//- (void)pay:(NSString *)orderNo orderServiceBool:(BOOL)orderServiceBool successBlock:(successBlock)successBlock failBlock:(failBlock)failBlock;

- (void)payWithType:(int)type orderNum:(NSString *)orderNo orderServiceBool:(BOOL)orderServiceBool successBlock:(successBlock)successBlock failBlock:(failBlock)failBlock;

@end
