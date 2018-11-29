//
//  HXListButton.h
//  demo
//
//  Created by Jney on 2016/11/9.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXListButton : UIView

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)list;

@end

@interface CellModel : NSObject

@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,assign) BOOL     isChoose;

@end
