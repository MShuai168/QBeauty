//
//  UserFlagsModel.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/8/5.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserFlagsModel : NSObject
@property (nonatomic, assign)BOOL bankFlag;
@property (nonatomic, assign)BOOL companyFlag;
@property (nonatomic, assign)BOOL contractFlag;
@property (nonatomic, assign)BOOL detailFlag;
@property (nonatomic, assign)BOOL freeFlag;
@property (nonatomic, assign)BOOL internetFlag;
@property (nonatomic, assign)BOOL schoolFlag;
@property (nonatomic, assign)BOOL authFlag;
@property (nonatomic, assign)BOOL lawFlag;
@property (nonatomic, assign)BOOL pullFlag;
@property (nonatomic, strong)NSString *identityFlag;
@end
