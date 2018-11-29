//
//  FileManager.m
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "FileManager.h"

@interface FileManager ()
@property (nonatomic, strong) AddressModel *provinceModel;
@end

@implementation FileManager

+ (FileManager *)manager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)getObjectFromTxtWithFileName:(NSString *)name {
    
    NSString *txtPath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    
    ///编码可以解决 .txt 中文显示乱码问题
    NSStringEncoding *useEncodeing = nil;
    //带编码头的如utf-8等，这里会识别出来
    NSString *body = [NSString stringWithContentsOfFile:txtPath
                                           usedEncoding:useEncodeing
                                                  error:nil];
    
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    if (!body) {
        body = [NSString stringWithContentsOfFile:txtPath
                                         encoding:0x80000632
                                            error:nil];
    }
    
    //还是识别不到，按GB18030编码再解码一次.
    if (!body) {
        body = [NSString stringWithContentsOfFile:txtPath
                                         encoding:0x80000631
                                            error:nil];
    }
    
    //展现
    if (body) {
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        id userData = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingMutableContainers
                                                        error:nil];
        return userData;
    }
    
    return nil;
    
}




- (AddressModel *)getProvinceModel:(NSString *)provinceCode {
    
    id object = [self getObjectFromTxtWithFileName:@"area"];
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        NSArray *items = (NSArray *)object[@"data"];
        
        NSArray *addresses = [AddressModel mj_objectArrayWithKeyValuesArray:items];
        
        __block AddressModel *item = nil;
        
        [addresses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([((AddressModel *)obj).areaCode isEqualToString:provinceCode]) {
                item = (AddressModel *)obj;
                *stop = YES;
            }
        }];
        self.provinceModel = item;
        return item;

    }
    return nil;
        
}

- (AddressModel *)getCityModel:(NSString *)cityCode {
    
    
    if (!self.provinceModel) {
        
        id object = [self getObjectFromTxtWithFileName:@"area"];
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            
            NSArray *items = (NSArray *)object[@"data"];
            
            AddressModel *item = nil;
            
            NSArray *addresses = [AddressModel mj_objectArrayWithKeyValuesArray:items];
            
            for (AddressModel *model in addresses) {
                for (AddressModel *obj in model.zones) {
                    if ([obj.areaCode isEqualToString:cityCode]) {
                        item = obj;
                        break;
                    }
                }
            }
            
            return item;
        }
        return nil;
        
    }

     __block AddressModel *item = nil;
    
    [self.provinceModel.zones enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([((AddressModel *)obj).areaCode isEqualToString:cityCode]) {
            item = (AddressModel *)obj;
            *stop = YES;
        }
    }];
    return item;
}


@end
