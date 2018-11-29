//
//  HXButton.h
//  DeliverSpeech
//
//  Created by Jney on 16/5/31.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXButton : UIButton
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,strong)NSString *titleStr;
-(void)timeStart;
- (void)invlidateTimer;
@end
