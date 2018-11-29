//
//  HXShareViewController.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXShareViewController : UIViewController

@end

@interface HXShareModel: NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *url;

@end
