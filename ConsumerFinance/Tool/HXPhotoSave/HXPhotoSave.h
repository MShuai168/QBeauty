//
//  HXPhotoSave.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/7/31.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBaseViewModel.h"
#import "HXPhotoModel.h"
typedef void (^photoProgressBlock)();
@interface HXPhotoSave : HXBaseViewModel
@property (nonatomic,assign)BOOL submitComplete;
@property (nonatomic,strong)dispatch_semaphore_t semaphore;
@property (nonatomic,strong)dispatch_queue_t quene;
@property (nonatomic,assign)BOOL stop;
@property (nonatomic,assign)BOOL commenPhotoBool; //评价YES
@property (nonatomic,assign)NSInteger count; //计算图片上传数量
@property (nonatomic,assign)BOOL inforPhotoBool;//判断资料认证图片 还是 评论上传图片  YES 资料认证
@property (nonatomic,assign)NSInteger successNumber; //成功上传的数量

@property (nonatomic,assign)NSInteger photoQuneNumber;//队列图片数量
+ (HXPhotoSave *)shareTools;
/**
 存储图片
 */
-(void)savePhotoWithOrderNumber:(HXPhotoModel *)model photoProgressBlock:(photoProgressBlock)block;

/**
 删除图片
 
 @param photoArr 删除图片的数组
 */
-(void)deletePhoto:(NSMutableArray *)photoArr;

@end
