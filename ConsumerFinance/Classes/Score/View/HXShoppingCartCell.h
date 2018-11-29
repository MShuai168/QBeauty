//
//  HXShoppingCartCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HXShopCarModel.h"
#import "HXProArrModel.h"
@protocol shopCartDelegate;
@interface HXShoppingCartCell : BaseTableViewCell
@property (nonatomic,strong)HXShopCarModel * model;
@property (nonatomic,assign)BOOL detailBool ; //兑换详情
@property (nonatomic,strong)HXProArrModel * proModel;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,assign)id<shopCartDelegate>delegate;
@end
@protocol shopCartDelegate <NSObject>

-(void)changeProduceShopCart:(HXShopCarModel *)model addBool:(BOOL)addBool;

-(void)selectProcut:(HXShopCarModel *)model;

-(void)changeTextField:(UITextField *)textField;

-(void)updateNewNumber:(UITextField *)textField model:(HXShopCarModel *)model index:(NSIndexPath *)indexPath;


@end
