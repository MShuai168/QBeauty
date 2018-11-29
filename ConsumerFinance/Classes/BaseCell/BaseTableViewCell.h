//
//  BaseTableViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDTextField.h"
/**
 资料认证状态
 */
typedef NS_ENUM(NSInteger, ShopStates) {
    ShopStatesAll,//全部
    ShopStatesWait,//等待付款
    ShopStatesWaitArchive, //等待收货
    ShopStatesSuccess, //已完成
    ShopStatesCancel//已取消
};
@interface BaseTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong)UIImageView * bankImage;

/**
 * cell标题
 */
@property (nonatomic,strong) UILabel * nameLabel;
/**
 * cell右面填写的textfield
 */
@property (nonatomic,strong) HDTextField * writeTextfield;
/**
 * cell右面的文本
 */
@property (nonatomic,strong) UILabel * titleLabel;
/**
 * 右侧点击按钮
 */
@property (nonatomic,strong) UIButton * rightButton;

@property (nonatomic,strong) UIImageView * headImage;

-(void)creatView;

/**
 * 创建分割线
 */
-(void)creatLine:(NSInteger)left hidden:(BOOL)hidden;
@end
