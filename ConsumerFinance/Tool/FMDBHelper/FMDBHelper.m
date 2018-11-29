//
//  FMDBHelper.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/7.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "FMDBHelper.h"

#import <FMDB/FMDatabase.h>

@interface FMDBHelper()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static FMDBHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[FMDBHelper alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self == [super init]) {
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *path = [document stringByAppendingPathComponent:@"ConsumerFinance.db"];
        
        _db = [FMDatabase databaseWithPath:path];
        
    }
    return self;
}

@end
