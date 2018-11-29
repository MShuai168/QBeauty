
///
//  currentLocation.m
//  huaxiafinance_user
//
//  Created by huaxiafinance on 16/1/8.
//  Copyright © 2016年 huaxiafinance. All rights reserved.
//

#import "CurrentLocation.h"

@interface CurrentLocation ()

@property (nonatomic,strong) AddressModelInfo *addressModel;
@property (nonatomic,assign) NSInteger        netCount;

@end

@implementation CurrentLocation

@synthesize addressModel;
//定位回调代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //NSMutableArray * userDefaultLanguages = [[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    
    CLLocation *currLocation=[locations lastObject];
    NSTimeInterval locationAge = -[currLocation.timestamp timeIntervalSinceNow];
//    NSLog(@"444444");
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
//    
//    NSLog(@"33333333 %f",locationAge);
//    NSLog(@"33333333");
   
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];//反向解析，根据经纬度反向解析出地址
    CLLocation *location = [locations objectAtIndex:0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        addressModel = [[AddressModelInfo alloc] init];
        for(CLPlacemark *place in placemarks){
            CLLocationCoordinate2D  coordinate = [self BD09FromGCJ02:currLocation.coordinate];
            //取出当前位置的坐标
            NSString *latStr = [NSString stringWithFormat:@"%f",coordinate.latitude];
            NSString *lngStr = [NSString stringWithFormat:@"%f",coordinate.longitude];
            NSDictionary *dict = [place addressDictionary];
            addressModel.subLocality = dict[@"SubLocality"];
            addressModel.city = dict[@"City"];
            addressModel.latitude = latStr;
            addressModel.longitude = lngStr;
            addressModel.state = dict[@"State"];
            addressModel.countryCode = dict[@"CountryCode"];
            addressModel.detailAddress = dict[@"Name"];
        }
        
        //获取经纬度
        if (self.getLocation && _netCount == 0) {
            self.getLocation(addressModel);
            _netCount = 1;
            [manager stopUpdatingLocation];
        }
    }];
    if (currLocation.horizontalAccuracy > 0) {
        //已经定位成功了 结束定位 ✔️✅
        [manager stopUpdatingLocation];
    }
}
/// 百度坐标转高德坐标
-(CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}

#pragma mark - 检测应用是否开启定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            [self openGPSTips];
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}


-(void)openGPSTips{
    if (!self.firstBool) {
        [KeyWindow displayMessage:@"你还没有开启定位权限"];
//        UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alet show];
        self.firstBool = YES;
    }
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//}

- (LocationAddress)getLocation {
//     _netCount = 0;
    return _getLocation;
}

//获取定位信息
-(void)getUSerLocation{
    _netCount = 0;
    _locaManager = [[CLLocationManager    alloc]init];
    
    //设置代理
    
    _locaManager.delegate=self;
    
    //设置定位精确度到米
    
    _locaManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    //设置过滤器为无
    
    _locaManager.distanceFilter=kCLDistanceFilterNone;
    
    //开始定位
    
    [_locaManager  requestWhenInUseAuthorization];//这句话ios8以上版本使用。
    [_locaManager  startUpdatingLocation];
    
}

+ (CurrentLocation *)sharedManager{
    static CurrentLocation *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)gpsCityWithLocationAddress:(LocationAddress)returnBlock {
//    if (!_locaManager) {
//        [self getUSerLocation];
//    }
    [self getUSerLocation];
    _netCount = 0;
    _getLocation = returnBlock;
    CLAuthorizationStatus status = [[self.locaManager class] authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined || kCLAuthorizationStatusDenied == status) {
        NSLog(@"定位失败");
        _getLocation(nil);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"Longitude"];
        [defaults setObject:@"" forKey:@"Latitude"];
        [defaults synchronize];
        
        return ;
    }
//    self.getLocation = returnBlock;
}

@end

@implementation AddressModelInfo

@end
