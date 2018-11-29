//
//  HXJobPhotoCollectionViewCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/4.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoModel.h"
#import "ComButton.h"
@interface HXJobPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel * progressLabel;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UIButton * upLoadBtn;
@property (nonatomic,strong)HXPhotoModel * model;
@property (nonatomic,strong)ComButton * deleteButton;
@property (nonatomic,assign)BOOL nostates; //无上传状态
@end
