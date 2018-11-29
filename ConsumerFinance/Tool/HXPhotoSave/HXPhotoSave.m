//
//  HXPhotoSave.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/7/31.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXPhotoSave.h"
@interface HXPhotoSave()
@property (nonatomic,strong)dispatch_group_t group;
@end
@implementation HXPhotoSave
+ (HXPhotoSave *)shareTools {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
-(id)init {
    
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(3);
        self.quene = dispatch_queue_create("hxmxq", DISPATCH_QUEUE_SERIAL);
        self.group = dispatch_group_create();
        self.count = 0;
        self.successNumber = 0;
        self.photoQuneNumber = 0;
        self.stop = NO;
    }
    return self;
    
}


-(void)savePhotoWithOrderNumber:(HXPhotoModel *)model photoProgressBlock:(photoProgressBlock)block{
    self.count ++;
    self.photoQuneNumber++;
    [self submitPhotoModel:model photoProgressBlock:block];
}
-(void)submitPhotoModel:(HXPhotoModel *)model photoProgressBlock:(photoProgressBlock)block{
    dispatch_semaphore_t semaphore = self.semaphore;
    dispatch_queue_t quene =  self.quene;
    //添加任务
    dispatch_group_async(self.group,quene, ^{
        if (self.semaphore) {
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        if (block) {
            
            [self progressPhotoModel:model photoProgressBlock:block];  //请求
        }
    });
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");
    });
}

-(void)deletePhoto:(NSMutableArray *)photoArr{
    for (int i = 0; i<photoArr.count; i++) {
        HXPhotoModel * model = [photoArr objectAtIndex:i];
        model.photoTag = i+500+1;
    }
}

-(void)progressPhotoModel:(HXPhotoModel *)model photoProgressBlock:(photoProgressBlock)block {
    NSLog(@"weadasdasda");
    if (self.stop) {
        if (self.semaphore) {
            
            dispatch_semaphore_signal(self.semaphore);
        }
        return;
    }
    self.submitComplete = NO;
    model.states = PhotoStatesProgress;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"text/json",
                                                         @"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates   = NO;
    manager.requestSerializer                         = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval         = 40;
    NSString * url ;
    if (_commenPhotoBool) {
        url = @"https://ios-yifenqi.huaxiafinance.com/huaxia-front/img/uploadCommon";
    }else {
        url = @"https://ios-yifenqi.huaxiafinance.com/huaxia-front/img/uploadSecret";
    }
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        NSData *forontData = [UIImage resetSizeOfImageDataWithSourceImage:model.photoImage maxSize:600];
        [formData appendPartWithFileData:forontData name:@"file" fileName:@"avatar.png" mimeType:@"image/png"];
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        CGFloat progres = (CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount;//这里是返回的上传图片进度,一定要用CGFloat进行接收
        if (progres) {
            model.progress = progres;
            NSLog(@"gresssss=================%f",progres);
            model.states = PhotoStatesProgress;
            if (!self.inforPhotoBool) {
                if (block) {
                    if (model.progress>=0.99) {
                        model.progress = 0.99;
                    }
                    block(model);
                }
            }
        }
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        self.count--;
        if (self.count==0) {
            
            self.submitComplete = YES;
        }
        if (self.inforPhotoBool) {
            
            dispatch_semaphore_signal(self.semaphore);
        }else {
            
            dispatch_semaphore_signal(self.semaphore);
            model.progress = 1;
            if (block) {
                block(model);
            }
        }
        NSLog(@"response:%@", responseObject);
        id response = [self parseResponseObject:responseObject];
        if (response) {
            
            if ([response isKindOfClass:[ResponseModel class]]) {
                ResponseModel * result = (ResponseModel *)response;
                if (IsEqualToSuccess(result.head.responseCode)) {
                    self.successNumber++;
                    model.progress = 1.00;
                    model.key = [result.body objectForKey:@"key"]?[result.body objectForKey:@"key"]:@"";
                    model.photoUrl = [result.body objectForKey:@"url"]?[result.body objectForKey:@"url"]:@"";
                    model.states = model.key.length!=0?PhotoStatesSuccess:PhotoStatesFail;
                    
                }else {
                    [self uploadFailWithModel:model];
                    
                }
                
            } else if ([response isKindOfClass:[ErrorModel class]]){
                [self uploadFailWithModel:model];
            }
        } else {
            [self uploadFailWithModel:model];
        }
        if (block) {
            
            block(model);
        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        self.count--;
        
        if (self.count==0) {
            self.submitComplete = YES;
        }

        [self uploadFailWithModel:model];
        
        if (block) {
            
            block(model);
        }
        
        if (self.semaphore) {
            
            dispatch_semaphore_signal(self.semaphore);
        }
    }];
}
#pragma mark --上传失败
-(void)uploadFailWithModel:(HXPhotoModel *)model {
    model.progress = 1.00;
    model.key = @"";
    model.photoUrl = @"";
    model.states = PhotoStatesFail;
}

- (id)parseResponseObject:(id)responseObject {
    
    if (!responseObject) {
        return nil;
    }
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        ResponseModel *success = [ResponseModel mj_objectWithKeyValues:responseObject];
        return success;
    }
    
    return nil;
}

@end
