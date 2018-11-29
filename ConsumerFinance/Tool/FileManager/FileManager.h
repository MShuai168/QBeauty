//
//  FileManager.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/25.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface FileManager : NSObject

+ (FileManager *)manager;

/***
 * para name:txt格式的文件名
 * return: 返回读取后的txt文件内容（读取不到时返回为nil）
 */
- (id) getObjectFromTxtWithFileName:(NSString *)name;

/***
 * para provinceCode:省份的code值
 * return: 省的模型
 */
- (AddressModel *)getProvinceModel:(NSString *)provinceCode;

/***
 * para cityCode:城市的code值
 * return: 城市的模型
 */
- (AddressModel *)getCityModel:(NSString *)cityCode;

@end
