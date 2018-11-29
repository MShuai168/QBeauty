//
//  HXRelationView.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/4/12.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXRelationView : UIView
@property (nonatomic,strong)NSString * name;
@property (nonatomic,copy)void (^select)();
-(id)initWithNameArray:(NSArray *)nameArr view:(UIView *)view;

/**
 根据tag值匹配按钮

 @param tag 名称
 */
-(void)screeButton:(NSString *)name;

-(void)updateButtonName:(NSString *)name;
@end
