//
//  currentLocation.h
//  huaxiafinance_user
//
//  Created by huaxiafinance on 16/1/8.
//  Copyright © 2016年 huaxiafinance. All rights reserved.
//  当前地理位置

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class AddressModelInfo;

typedef void(^LocationAddress)(AddressModelInfo* addressModel);

@interface CurrentLocation : NSObject<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locaManager;
@property (nonatomic,strong) LocationAddress getLocation;
@property (nonatomic,strong)CLLocation *currLocation;
@property (nonatomic,copy)void(^currLocationBlock)();
@property (nonatomic,assign)BOOL updateLocation; //判断更新位置
//@property (nonatomic,strong) NSString *gpsCity; // 地位到的城市
@property (nonatomic,assign)BOOL firstBool; //标记第一次定位

+ (CurrentLocation *)sharedManager;
//获取定位信息
-(void)getUSerLocation;

//-(void)gpsCityWithLocationAddress:(LogicalAddress)LogicalAddress;

-(void)gpsCityWithLocationAddress:(LocationAddress)returnBlock;

@end

@interface AddressModelInfo : NSObject
/**
 *  区县
 */
@property (nonatomic,strong) NSString *subLocality;
/**
 *  市
 */
@property (nonatomic,strong) NSString *city;//市
/**
 *  纬度
 */
@property (nonatomic,strong) NSString *latitude;//纬度
/**
 *  经度
 */
@property (nonatomic,strong) NSString *longitude;//经度
/**
 *  省份
 */
@property (nonatomic,strong) NSString *state;//省份
/**
 *  国际区域
 */
@property (nonatomic,strong) NSString *countryCode;//国际区域
/**
 *  街道
 */
@property (nonatomic,strong) NSString *detailAddress;//街道




@end
