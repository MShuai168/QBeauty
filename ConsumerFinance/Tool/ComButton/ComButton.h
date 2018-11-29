//
//  ComButton.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComButton : UIButton
@property (nonatomic,strong)UIImageView * photoImage;//icon
@property (nonatomic,strong)UILabel * nameLabel;//标题
@end

/**
 *  ScreenButton
 */

@interface ScreenButton : UIButton

@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView * arrowimage;

@end
