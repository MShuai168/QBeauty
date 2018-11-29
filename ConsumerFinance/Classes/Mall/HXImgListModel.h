//
//  HXImgListModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/3.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXImgListModel : NSObject
@property (nonatomic,strong) NSString *  id; //图片id
@property (nonatomic,strong) NSString *  imgUrl;//图片地址
@property (nonatomic,strong) NSString *  sort; //图片所属总类
@property (nonatomic,strong) NSString *  type ;//图片类型
@property (nonatomic,strong) NSString *  typeParam;//图片所属项目id
@end
