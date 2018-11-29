//
//  HXPhotoProgress.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol progressDelegate;
@interface HXPhotoProgress : UIView
@property (nonatomic,strong)UIView * progressInView;
@property (nonatomic,strong)UIView * progressView;
@property (nonatomic,strong)UILabel * inforLabel;
@property (nonatomic,strong)UILabel * uploadInformationLabel;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,assign)id<progressDelegate>delegate;

/**
 创建UI
 */
-(void)creatUI;
@end
@protocol progressDelegate <NSObject>

/**
 取消上传
 */
-(void)cancelAction;

@end
