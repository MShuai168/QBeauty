//
//  ImageAttachmentTableViewCell.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/20.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickEventBlock)(id object, NSString *eventType);

@interface ImageAttachmentTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString          *title;
@property (nonatomic, copy  ) clickEventBlock   block;
@property (nonatomic, strong) NSString          *eventType;

@property (nonatomic, strong) UILabel       *uiTitle;
@property (nonatomic, strong) UIButton      *uiChange;
@property (nonatomic, strong) UIImageView   *uiAdd;
@property (nonatomic, assign) BOOL          enableAdd;
@property (nonatomic, assign) BOOL          enableChange;


@end
