//
//  HXPhotoModel.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/8/3.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,PhotoStates) {
    PhotoStatesWait,                  //图片等待上传
    PhotoStatesProgress,              //图片上传中
    PhotoStatesSuccess,               //图片上传成功
    PhotoStatesFail ,                 //图片上传失败
};
@interface HXPhotoModel : NSObject
@property (nonatomic,strong)NSString * photoUrl;
@property (nonatomic,strong)NSString * comPhotoUrl; //原图Url
@property (nonatomic,assign)NSInteger photoTag;
@property (nonatomic,strong)UIImage * photoImage;
@property (nonatomic,strong)NSString * key;
@property (nonatomic,assign)PhotoStates states ; //图片上传状态
@property (nonatomic,assign)CGFloat progress; //上传进度
@property (nonatomic,assign)BOOL serverSuccess;//已经成功上传到安硕
@property (nonatomic,assign)BOOL haveUpload;//已经上传 但是没有上传到安硕的标记
@end
