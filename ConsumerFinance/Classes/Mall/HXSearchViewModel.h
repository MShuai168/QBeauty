//
//  HXSearchViewModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/2.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXBaseViewModel.h"
#import "CurrentLocation.h"
@interface HXSearchViewModel : HXBaseViewModel
@property (nonatomic,strong) AddressModelInfo * addressModel;
/**
 获取热词
 
 @param block 回调
 */
-(void)archiveHotType:(ReturnValueBlock)returnBlock;

/**
 获取关键词

 @return 关键词数组
 */
-(NSMutableArray *)archiveKeyWord;


/**
 保存关键字

 @param name 关键字
 */
-(void)conserveKeyWord:(NSString *)name;
@end
