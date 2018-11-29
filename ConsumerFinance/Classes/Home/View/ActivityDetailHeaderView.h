//
//  ActivityDetailHeaderView.h
//  ConsumerFinance
//
//  Created by Shuai on 2018/9/25.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZYBannerView/ZYBannerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

NS_ASSUME_NONNULL_END
