//
//  HomeDetailViewController.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/1.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeDetailHeaderView.h"
#import "HomeDetailActivityCell.h"
#import "HomeDetailActivityDetailVC.h"
#import "FileManager.h"
#import "BookingViewController.h"

typedef struct {
    CLLocationDistance latitudinalMeters;   //纬度距离
    CLLocationDistance longitudinalMeters;  //经度距离
    CLLocationCoordinate2D centerCoord;     //地图中心点
} CoordinateRegion;

@interface HomeDetailViewController () <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *_manager;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) HomeDetailHeaderView *headerView;
@property (nonatomic, copy) NSString *address;  //门店详细地址
@property (nonatomic, copy) NSString *currentAddress;  //当前位置
@property (nonatomic, assign) float lat; //门店地址纬度
@property (nonatomic, assign) float log; //门店地址经度
@property (nonatomic, copy) NSString *tenantId;
@property (nonatomic, copy) NSString *activitiesBack;  //判断是否从'门店活动'界面返回
@property (nonatomic, copy) NSString *bookingBack;  //判断是否从'预约'界面返回

@end

@implementation HomeDetailViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        _tableView.backgroundColor = kUIColorFromRGB(0xF5F7F7);
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (HomeDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HomeDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 375)];
        _headerView.mapView.delegate = self;
        [_headerView.phoneButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.mapsButton addTarget:self action:@selector(mapsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        _headerView.block = ^(UIButton *sender) {
            [weakSelf bookingButtonAction:sender];
        };
    }
    return _headerView;
}

//拨打电话☎️
- (void)callButtonAction:(UIButton *)sender {
//    NSLog(@"%@",sender.titleLabel.text);
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",sender.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

//打开系统地图导航
- (void)mapsButtonAction:(UIButton *)sender {
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(self.lat, self.log);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
    currentLocation.name = self.currentAddress;
    toLocation.name = self.address;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}

//门店预约
- (void)bookingButtonAction:(UIButton *)sender {
////    未登录状态下，点击店铺时，弹出账号登录页面
    if (![[AppManager manager] isOnline]) {
        [Helper pushLogin:self];
        self.bookingBack = @"returnBack";
        return;
    }
    BookingViewController *VC = [[BookingViewController alloc] init];
    VC.tenantId = self.tenantId;
    VC.block = ^(NSString *str) {
        self.bookingBack = str;
    };
    VC.nameStr = self.headerView.shopNameLabel.text;
    VC.address = self.headerView.addressLabel.text;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //定位功能可用
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        //设置地图
        [self useMkMapKit];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //定位不能用
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertC addAction:action];
        
        if ([self.activitiesBack isEqualToString:@"returnBack"] || [self.bookingBack isEqualToString:@"returnBack"]) {
            NSLog(@"不要弹出定位权限设置界面");
        } else {
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    
    self.title = @"门店详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailActivityCell" bundle:nil] forCellReuseIdentifier:@"HomeDetailActivityCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeadRefreshWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addFooterRefreshWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = 1;
    [self loadHomeDetailData];
}

-(void)useMkMapKit {
    //  地图类型，默认为基本类型
    //  MKMapTypeSatellite 卫星
    //  MKMapTypeStandard  基本
    //  MKMapTypeHybrid   混合
    self.headerView.mapView.mapType = MKMapTypeStandard;
    
    //获取定位管理对象
    _manager = [[CLLocationManager alloc] init];
    [_manager requestAlwaysAuthorization];
    
    
    //精准度
    /*
     kCLLocationAccuracyBestForNavigation   导航精准（导航使用）
     kCLLocationAccuracyBest 普通精准
     kCLLocationAccuracyNearestTenMeters  误差十米
     kCLLocationAccuracyHundredMeters  误差百米
     kCLLocationAccuracyKilometer  误差千米
     kCLLocationAccuracyThreeKilometers  误差三千米
     */
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //定位距离过滤器，超过10米，才重新定位一次
    _manager.distanceFilter = 10;
    
    //设置代理
    _manager.delegate = self;
    
    //开始定位
    [_manager startUpdatingLocation];
    //开始方向定位
    [_manager startUpdatingHeading];
//
//    //显示当前用户的位置
//    self.headerView.mapView.showsUserLocation = YES;
}

#pragma mark -- 实现定位协议
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //拿到定位的位置
    CLLocation *location = [locations lastObject];
//
////    //缩放比例
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
//    [self.headerView.mapView setRegion:region animated:YES];
    
//    //停止定位
    [manager stopUpdatingLocation];
    
    //声明地理编码属性，用于路线规划功能
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
//            NSLog(@"name,%@",place.name);                              // 位置名
//            NSLog(@"subThoroughfare,%@",place.subThoroughfare);        // 子街道
//            NSLog(@"thoroughfare,%@",place.thoroughfare);              // 街道
//            NSLog(@"subLocality,%@",place.subLocality);                // 区
//            NSLog(@"locality,%@",place.locality);                      // 市
//            NSLog(@"administrativeArea%@",place.administrativeArea);  //省
//            NSLog(@"country,%@",place.country);                        // 国家
            self.currentAddress = [NSString stringWithFormat:@"%@%@%@%@",place.locality, place.subLocality, place.thoroughfare, place.name];
        }
        
        [geocoder geocodeAddressString:self.currentAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count == 0) return;
            // 开始位置的地标
            CLPlacemark *startCLPlacemark = [placemarks firstObject];
            // 添加起点的大头针
            MKPointAnnotation *startAnno = [[MKPointAnnotation alloc] init];
//            startAnno.title = startCLPlacemark.locality;
//            startAnno.subtitle = startCLPlacemark.name;
//            NSArray *array = startCLPlacemark.addressDictionary[@"FormattedAddressLines"];
//            startAnno.title = array.firstObject;
            startAnno.title = self.currentAddress;
            startAnno.coordinate = startCLPlacemark.location.coordinate;
            //添加大头针
            [self.headerView.mapView addAnnotation:startAnno];
            
            
//            获取结束位置的地标
            [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {

                if (placemarks.count == 0) return;
                // 结束位置的地标
                CLPlacemark *endCLPlacemark = [placemarks firstObject];
                // 添加终点的大头针
                MKPointAnnotation *endAnno = [[MKPointAnnotation alloc] init];
//                endAnno.title = endCLPlacemark.locality;
//                endAnno.subtitle = endCLPlacemark.name;
                endAnno.title = self.headerView.shopNameLabel.text; //店铺名称
                endAnno.subtitle = self.address; //店铺地址
                endAnno.coordinate = endCLPlacemark.location.coordinate;
                //添加大头针
                [self.headerView.mapView addAnnotation:endAnno];
                NSLog(@"起点:%@  终点:%@", self.currentAddress, self.address);
                
                CLLocation *l1 = location;
                CLLocation *l2 = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.log];
                [self mapTrackShowRegionWithLocation:@[l1, l2]];
                
                // 开始导航
                [self startDirectionsWithstartCLPlacemark:startCLPlacemark
                                           endCLPlacemark:endCLPlacemark];
            }];
        }];
    }];
    
//    NSLog(@"%f    %f",location.coordinate.latitude, location.coordinate.longitude);
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CLLocationCoordinate2D start = {location.coordinate.latitude, location.coordinate.longitude};
//        CLLocationCoordinate2D end = {self.lat, self.log};
//        [self drawLineWithStartingPoint:start andEndPoint:end];
//    });
}
//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"失败原因:%@", error);
}

/**
 *  发送请求获取路线相信信息
 *  @param startCLPlacemark 起点的地标
 *  @param endCLPlacemark   终点的地标
 */
- (void)startDirectionsWithstartCLPlacemark:(CLPlacemark *)startCLPlacemark endCLPlacemark:(CLPlacemark *)endCLPlacemark {
    // 创建起点对象
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithPlacemark:startCLPlacemark];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];

    // 创建终点对象
    MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithPlacemark:endCLPlacemark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];

    // 创建request对象
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    // 设置起点
    request.source = startItem;
    // 设置终点
    request.destination = endItem;

    // 1.发送请求到苹果的服务器获取导航路线信息
    // 接收一个MKDirectionsRequest请求对象, 我们需要在该对象中说清楚:从哪里 --> 到哪里
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];

    // 2.计算路线信息, 计算完成之后会调用blcok
    // 在block中会传入一个响应者对象(response), 这个响应者对象中就存放着路线信息
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        // 打印获取到的路线信息
        if (error) {
            NSLog(@"路线绘制失败 %@", error);
        } else {
//            // 2.1获取所有的路线
//            NSArray *routes = response.routes;
//            for (MKRoute *route in routes) {
////                NSLog(@"%f千米   %f小时", route.distance / 1000, route.expectedTravelTime/ 3600);
//                //  3.绘制路线(本质: 往地图上添加遮盖)
//                // 传递当前路线的几何遮盖给地图, 地图就会根据遮盖自动绘制路线
//                // 当系统开始绘制路线时会调用代理方法询问当前路线的宽度/颜色等信息
//                [self.headerView.mapView addOverlay:route.polyline];
//            }
            //取出一条路线
            MKRoute *route = response.routes[0];
            //关键节点
            for(MKRouteStep *step in route.steps) {
                //添加路线
                [self.headerView.mapView addOverlay:step.polyline];
            }
        }
    }];
}

//- (void)drawLineWithStartingPoint:(CLLocationCoordinate2D)start andEndPoint:(CLLocationCoordinate2D)end {
////    //起点和终点的经纬度
////    CLLocationCoordinate2D start = {39.9087607478,116.3975780499};
////    CLLocationCoordinate2D end = {40.9087607478,117.3975780499};
//
//    //起点终点的详细信息
//    MKPlacemark *startPlace = [[MKPlacemark alloc] initWithCoordinate:start addressDictionary:nil];
//    // 添加起点的大头针
//    MKPointAnnotation *startAnno = [[MKPointAnnotation alloc] init];
//    startAnno.title = startPlace.locality;
//    startAnno.subtitle = startPlace.name;
//    startAnno.coordinate = startPlace.location.coordinate;
//    //添加大头针
//   [self.headerView.mapView addAnnotation:startAnno];
//    MKPlacemark *endPlace = [[MKPlacemark alloc] initWithCoordinate:end addressDictionary:nil];
//    // 添加终点的大头针
//    MKPointAnnotation *endAnno = [[MKPointAnnotation alloc ] init];
//    endAnno.title = endPlace.locality;
//    endAnno.subtitle = endPlace.name;
//    endAnno.coordinate = endPlace.location.coordinate;
//    //添加大头针
//   [self.headerView.mapView addAnnotation:endAnno];
//    //起点 终点
//    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlace];
//    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlace];
//    startItem.name = self.currentAddress;
//    endItem.name = self.address;
//
//    //路线请求
//    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
//    request.source = startItem;
//    request.destination = endItem;
//    //request.transportType = MKDirectionsTransportTypeAny;//车行模式
//
//    request.requestsAlternateRoutes = YES;
//
//    //发送请求
//    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
//
//    __block NSInteger sumDistance = 0;
////    计算
//    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//        NSLog(@"++++响应:%@", response);
//        if (!error) {
//            //取出一条路线
//            MKRoute *route = response.routes[0];
//            //关键节点
//            for(MKRouteStep *step in route.steps) {
//////                大头针
////                MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
////                annotation.coordinate = step.polyline.coordinate;
////                annotation.title = step.polyline.title;
////                annotation.subtitle = step.polyline.subtitle;
////                //添加大头针
////                [self.headerView.mapView addAnnotation:annotation];
//
//                //添加路线
//                [self.headerView.mapView addOverlay:step.polyline];
//
//                //距离
//                sumDistance += step.distance;
//            }
//            NSLog(@"总距离 %ld",sumDistance);
//        } else {
//            NSLog(@"%@", error);
//        }
//    }];
//}

//标注的代理方法
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView * view= [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"anno"];
    view.canShowCallout = YES;
    return view;
}

// 绘制路径的样式
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    // 创建一条路径遮盖
    // 注意, 创建线条时候,一定要制定几何路线
    MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    line.lineWidth = 2; // 路线的宽度
    line.strokeColor = [UIColor redColor]; // 路线的颜色
//    pathRender.lineJoin = kCGLineJoinRound;
    // 返回路线
    return line;
}


#pragma mark - refresh
- (void)loadNewData {
    self.page = 1;
    [self loadHomeDetailData];
}
- (void)loadMoreData {
    self.page += 1;
    [self loadHomeDetailData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasource > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.datasource.count > 0 ? 50 : 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.datasource.count > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = ColorWithHex(0xF5F7F7);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 120, 30)];
        titleLabel.text = @"门店活动";
        [view addSubview:titleLabel];
//        view.backgroundColor = [UIColor greenColor];
//        titleLabel.backgroundColor = [UIColor magentaColor];
        return view;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeDetailActivityCell"];
    HomeDetailActivityModel *model = self.datasource[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeDetailActivityModel *model = self.datasource[indexPath.row];
    HomeDetailActivityDetailVC *VC = [[HomeDetailActivityDetailVC alloc] init];
    VC.id = model.id;
    VC.block = ^(NSString *str) {
        self.activitiesBack = str;
    };
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)loadHomeDetailData {
    [MBProgressHUD showMessage:nil toView:self.view];
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%d", self.id], @"page":[NSString stringWithFormat:@"%d",self.page], @"rows":@10, @"selfLo":[NSString stringWithFormat:@"%.6f",self.longitude], @"selfLa":[NSString stringWithFormat:@"%.6f",self.latitude]};
    [[HXNetManager shareManager] get:@"tenant/detail" parameters:parameters sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.datasource removeAllObjects];
            }
            NSDictionary *dic = responseNewModel.body[@"tenant"];
            self.headerView.shopNameLabel.text = dic[@"shopName"];
            self.headerView.addressLabel.text = dic[@"address"];
            self.headerView.distanceLabel.text = dic[@"distanceStr"];
            [self.headerView.phoneButton setTitle:dic[@"tel"] forState:UIControlStateNormal];
            self.headerView.openingTimeLabel.text = [NSString stringWithFormat:@"%@-%@", dic[@"startTime"], dic[@"endTime"]];
            self.log = [dic[@"longitude"] floatValue];
            self.lat = [dic[@"latitude"] floatValue];
            self.tenantId = dic[@"tenantId"];
            
            NSString *provinceCode = dic[@"province"];
            NSString *cityCode = dic[@"city"];

            id object = [[FileManager manager] getObjectFromTxtWithFileName:@"areaZones"];
            if ([object isKindOfClass:[NSDictionary class]]) {
                NSArray *items = (NSArray *)object[@"data"];
//                NSLog(@"%@",items);
                NSString *provinceStr = @"";
                NSString *cityStr = @"";
                for (NSDictionary *dicx in items) {
                    if ([dicx[@"areaCode"] isEqualToString:provinceCode]) {
                        provinceStr = dicx[@"areaName"];
                        NSArray *zones = dicx[@"zones"];
                        for (NSDictionary *dict in zones) {
                            if ([dict[@"areaCode"] isEqualToString:cityCode]) {
                                cityStr = dict[@"areaName"];
                                break;
                            }
                        }
                        break;
                    }
                }
                NSString *str = dic[@"address"];
                if (![str containsString:cityStr] && ![str containsString:provinceStr]) {
                    self.address = [NSString stringWithFormat:@"%@%@",cityStr,str];  //店铺地址
                } else {
                    self.address = str;
                }
            }
            
            NSArray *arrayList = [responseNewModel.body valueForKey:@"activities"];
            for (NSDictionary *dict in arrayList) {
                HomeDetailActivityModel *model = [HomeDetailActivityModel initWithDictionary:dict];
                [self.datasource addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
        //停止刷新
        [self.tableView endRefreshHeaderAndFooter];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)dealloc {
    self.headerView.mapView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --MapView 路线居中显示在地图可见区域--
//https://www.jianshu.com/p/5aa09177ba55
/**
 *  找出地图可显示区域参数
 *  @param locations 存放地图CLLocation点的数组
 *  @return CoordinateRegion(经度距离、纬度距离、地图中心点)
 */
- (CoordinateRegion *)makeCoordinateCoordinateRegionWithLocation:(NSArray *)locations {
    CoordinateRegion *coordinateRegion = malloc(sizeof(CoordinateRegion));
    
    NSArray *latitudes = [self rankRouteWithLocations:locations latitude:YES];
    NSArray *longitudes = [self rankRouteWithLocations:locations latitude:NO];
    
    //  找到地图中的最大点和小点
    CLLocation *MinLatitude = [latitudes firstObject];
    CLLocation *MaxLatitude = [latitudes lastObject];
    CLLocation *MinLongitude = [longitudes firstObject];
    CLLocation *MaxLongitude = [longitudes lastObject];
    
    // 转成CLLocationDegrees
    CLLocationDegrees MinLatitudeDegrees = MinLatitude.coordinate.latitude;
    CLLocationDegrees MaxLatitudeDegrees = MaxLatitude.coordinate.latitude;
    CLLocationDegrees MinLongitudeDegrees = MinLongitude.coordinate.longitude;
    CLLocationDegrees MaxLongitudeDegrees = MaxLongitude.coordinate.longitude;
    CLLocationDegrees centerLa = (MinLatitudeDegrees + MaxLatitudeDegrees)/2;  // 纬度中心点
    CLLocationDegrees centerLo = (MinLongitudeDegrees + MaxLongitudeDegrees)/2;// 经度中心店
    
    // 计算经纬度  最远点和最近点之前的距离
    CLLocationDistance latitudeDistance = [MinLatitude distanceFromLocation:MaxLatitude] + 100;
    CLLocationDistance longitudeDistance = [MinLongitude distanceFromLocation:MaxLongitude] + 100;
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(centerLa, centerLo);
    
    coordinateRegion->latitudinalMeters = latitudeDistance;
    coordinateRegion->longitudinalMeters = longitudeDistance;
    coordinateRegion->centerCoord = centerCoord;
    
    return coordinateRegion;
}

/**
 *  排序
 *  @param locations 存放地图CLLocation点的数组
 *  @param isLatitude   按照纬度排序
 *  @return 排序后的经度/ 纬度 CLLocation 数组
 */
-(NSArray*)rankRouteWithLocations:(NSArray *)locations  latitude:(BOOL)isLatitude {
    NSMutableArray *pointArray=[NSMutableArray arrayWithArray:locations];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES comparator:^NSComparisonResult(id obj1, id obj2) {
        CLLocation *point1 = obj1;
        CLLocation *point2 = obj2;
        double lat1 = isLatitude?point1.coordinate.latitude:point1.coordinate.longitude;
        double lat2 = isLatitude?point2.coordinate.latitude:point2.coordinate.longitude;
        if (lat1 > lat2) {
            return NSOrderedDescending;
        } else if (lat1 < lat2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    [pointArray sortUsingDescriptors:[NSArray arrayWithObject:sort1]];
    
    return pointArray;
}

/**
 *  地图显示区域
 *  @param locations 存放地图CLLocation点的数组
 */
- (void)mapTrackShowRegionWithLocation:(NSArray *)locations {
    // 地图缩放显示。缩放区域
    MKCoordinateSpan span;
    span.latitudeDelta = 0.003f;
    span.longitudeDelta = 0.003f;
    CoordinateRegion *reginCoordinate = [self makeCoordinateCoordinateRegionWithLocation:locations];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(reginCoordinate->centerCoord, reginCoordinate->latitudinalMeters, reginCoordinate->longitudinalMeters);
    [self.headerView.mapView regionThatFits:region];
    [self.headerView.mapView setRegion:region animated:YES];
}




/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
