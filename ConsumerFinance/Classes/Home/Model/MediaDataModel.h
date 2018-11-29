//
//  MediaDataModel.h
//  ConsumerFinance
//
//  Created by huaxiafinance_ios on 16/11/30.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaDataModel : NSObject

@property (nonatomic,copy) NSString *imageName; //影像名称
@property (nonatomic,copy) NSString *serialNum; //序列号
@property (nonatomic,copy) NSString *tabFlag; //是否为标题
@property (nonatomic,copy) NSString *imageAlias; //英文别名
@property (nonatomic,copy) NSString *classCode; //目录编码

@property (nonatomic,copy) NSString *pageId; //图片ID


@property (nonatomic,copy) NSString *pageIdMap; //图片
@property (nonatomic,copy) NSString *cardType; //图片类型
@end
