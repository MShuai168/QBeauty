//
//  MyPositionTableViewCell.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPositionModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *imageName;
@end


typedef void (^clickEventBlock)(id object);

@interface MyPositionTableViewCell : UITableViewCell

@property (nonatomic, copy) clickEventBlock block;
- (void) setObject:(MyPositionModel *)positionModel;

@end


