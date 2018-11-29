//
//  HXCitySelectedViewModel.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/3/20.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCitySelectedViewModel.h"
#import "HotListModel.h"
#import "VoListModel.h"
#import "FileManager.h"

#import <MJExtension/MJExtension.h>

@interface HXCitySelectedViewModel()

@property (nonatomic, strong, readwrite) NSMutableArray *indexArray; // 字母索引
@property (nonatomic, strong, readwrite) NSMutableArray *hotCitys; // 热门城市
@property (nonatomic, strong, readwrite) NSMutableArray *cities; // 城市
@property (nonatomic, strong, readwrite) NSMutableArray *searchResult;

@end

@implementation HXCitySelectedViewModel

- (instancetype)init {
    if (self == [super init]) {
        _hiddenTableView = NO;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _hotCitys = [HotListModel changeHotListData:[HotListModel findAll]];
            _cities =[VoListModel changeHotList];
            _indexArray = [VoListModel changeScreenList];
            [_indexArray insertObject:@"热门" atIndex:0];
            if (_cities.count == 0) {
                [self defaultCity];
            }
        });
    }
    return self;
}

- (void)defaultCity {
    NSDictionary * object = [[FileManager manager] getObjectFromTxtWithFileName:@"cityXXX"];
    NSDictionary *body = [object objectForKey:@"body"];
    NSArray *hotList = [HotListModel mj_objectArrayWithKeyValuesArray:[body objectForKey:@"hotList"]];
    NSArray *voList = [VoListModel mj_objectArrayWithKeyValuesArray:[body objectForKey:@"voList"]];
    [self saveCityInformation];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _hotCitys = [HotListModel changeHotListData:hotList];
        _cities = [VoListModel changeHotList:voList];
        _indexArray = [VoListModel changeScreenList:voList];
        [_indexArray insertObject:@"热门" atIndex:0];
        [self.tableView reloadData];
        [self.hotCityCollectionView reloadData];
    });
    
}

-(void)updateCityListReturnBlock:(void(^)())block fail:(FailureBlock)failBlock{
    
    NSDictionary *head = @{@"tradeCode" : @"0100",
                           @"tradeType" : @"appService"};
    NSString *cityupdatetime = [[NSUserDefaults standardUserDefaults] objectForKey:CreatTime];
    NSDictionary *body = @{@"cityupdatetime":cityupdatetime ?cityupdatetime:@""};
    
    [[AFNetManager manager] postRequestWithHeadParameter:head
                                           bodyParameter:body
                                                 success:^(ResponseModel *object) {
                                                     
                                                     if (IsEqualToSuccess(object.head.responseCode)) {
                                                         if ([object.body objectForKey:@"cityupdatetime"] && cityupdatetime) {
                                                             
                                                             if ([[object.body objectForKey:@"cityupdatetime"] isEqualToString:cityupdatetime]) {
                                                                 return ;
                                                             }
                                                         }
                                                         [HotListModel clearTable];
                                                         [VoListModel clearTable];
                                                         for (int i =0; i<[[object.body objectForKey:@"hotList"] count]; i++) {
                                                             HotListModel * model = [HotListModel mj_objectWithKeyValues:[[object.body objectForKey:@"hotList"] objectAtIndex:i]];
                                                             [model save];
                                                         }
                                                         
                                                         for (int i =0; i<[[object.body objectForKey:@"voList"] count]; i++) {
                                                             VoListModel * model = [VoListModel mj_objectWithKeyValues:[[object.body objectForKey:@"voList"] objectAtIndex:i]];
                                                             
                                                             [model save];
                                                         }
                                                         
                                                         [[NSUserDefaults standardUserDefaults] setObject:[object.body objectForKey:@"cityupdatetime"] ? [[object.body objectForKey:@"cityupdatetime"] stringValue] : @""
                                                                                                   forKey:CreatTime];
                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                         
                                                         
                                                         dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                             _hotCitys = [HotListModel changeHotListData:[HotListModel findAll]];
                                                             
                                                             _cities =[VoListModel changeHotList];
                                                             _indexArray = [VoListModel changeScreenList];
                                                             [_indexArray insertObject:@"热门" atIndex:0];
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 // something
                                                                 block();
                                                             });
                                                         });
                                                         
                                                     }else {
                                                         if (!cityupdatetime) {
                                                             failBlock();
                                                         }
                                                     }
                                                     
                                                 } fail:^(ErrorModel *error) {
                                                     if (!cityupdatetime) {
                                                         failBlock();
                                                     }
                                                 }];
    
    
    
    
}
-(void)saveCityInformation {
    NSMutableArray * cities =[VoListModel changeHotList];
    if (cities.count==0) {
        [HotListModel clearTable];
        [VoListModel clearTable];
        NSDictionary * object = [[FileManager manager] getObjectFromTxtWithFileName:@"cityXXX"];
        NSDictionary *body = [object objectForKey:@"body"];
        NSArray *hotList = [HotListModel mj_objectArrayWithKeyValuesArray:[body objectForKey:@"hotList"]];
        NSArray *voList = [VoListModel mj_objectArrayWithKeyValuesArray:[body objectForKey:@"voList"]];
        for (int i =0; i<[hotList count]; i++) {
            HotListModel * model = [HotListModel mj_objectWithKeyValues:[hotList objectAtIndex:i]];
            [model save];
        }
        
        for (int i =0; i<[voList count]; i++) {
            VoListModel * model = [VoListModel mj_objectWithKeyValues:[voList objectAtIndex:i]];
            
            [model save];
        }
    }
    
}

- (NSArray *)searchCities {
    return self.searchResult;
}

- (void)fillSearchCities:(NSString *)key {
    
    self.searchResult = [[NSMutableArray alloc] init];
    __weak __typeof__ (self) wself = self;
    [self.cities enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = [[dic allValues] firstObject];
        [arr enumerateObjectsUsingBlock:^(NSString *city, NSUInteger idx, BOOL * _Nonnull stop) {
            __strong __typeof (wself) sself = wself;
            BOOL isHaveChinese = [key isHaveChinese];
            if (isHaveChinese) {
                if ([city containsString:key]) {
                    [sself.searchResult addObject:city];
                }
                return ;
            }
            
            NSString *firstCharactor = [self firstCharactor:city];
            NSString *pinyin = [[[self chineseCharactor:city] stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
            if ([firstCharactor containsString:[key uppercaseString]] || [pinyin containsString:[key uppercaseString]]) {
                [sself.searchResult addObject:city];
            }
        }];
        
    }];
}

- (NSString *)chineseCharactor:(NSString *)aString {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    
    return pinYin;
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString {
    NSString *pinYin = [self chineseCharactor:aString];
    NSArray *array = [pinYin componentsSeparatedByString:@" "];
    __block NSString *firstCharactors = @"";
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        firstCharactors = [firstCharactors stringByAppendingString:[obj substringToIndex:1]];
    }];
    
    return firstCharactors;
}


@end
