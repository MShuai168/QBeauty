//
//  HXCommentModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXCommentModel : NSObject
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * date;
@property (nonatomic,strong) NSMutableArray * photoArr;
@property (nonatomic,assign) NSInteger star;
@property (nonatomic,assign) float titleHeight;
@property (nonatomic,assign)BOOL contentLength;//判断是否超过5行
@property (nonatomic,assign)BOOL seeAll;
@property (nonatomic,assign) NSInteger photoHeight;
@property (nonatomic,assign) float cellHeight;


@property (nonatomic,strong)NSString * cellPhone;
@property (nonatomic,strong)NSString * commentAt ;
@property (nonatomic,strong)NSString * commentDate;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,strong)NSString * countScore;
@property (nonatomic,strong)NSString * createAt;
@property (nonatomic,strong)NSString * finishDate;
@property (nonatomic,strong)NSString * handleAt;
@property (nonatomic,strong)NSString * handleId;
@property (nonatomic,strong)NSString * handleRemarks;
@property (nonatomic,strong)NSString * handleStatus;
@property (nonatomic,strong)NSString * icon;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * isPhoney;
@property (nonatomic,strong)NSString * merId;
@property (nonatomic,strong)NSString * merName;
@property (nonatomic,strong)NSString * orderNo;
@property (nonatomic,strong)NSString * proId;
@property (nonatomic,strong)NSString * proName;
@property (nonatomic,strong)NSString * qualityScore;
@property (nonatomic,strong)NSString * serviceScore;

-(void)adjustModel:(NSDictionary *)dic;
@end
