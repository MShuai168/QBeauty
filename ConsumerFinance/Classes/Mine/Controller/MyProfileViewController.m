//
//  MyProfileViewController.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/16.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "MyProfileViewController.h"
#import "XMNPhotoPickerController.h"
#import <AliyunOSSiOS.h> //阿里云

@interface MyProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UITableView *_tableView;
}

@property (nonatomic,strong)BaseTableViewCell * headCell; //头像cell

@property(nonatomic, strong) OSSClient * client;

@property(nonatomic, copy) NSString *accessKeyId;
@property(nonatomic, copy) NSString *accessKeySecret;
@property(nonatomic, copy) NSString *securityToken;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self editNavi];
    [self createTableView];
    [self request];
    
    //阿里云图片上传临时授权token
    [self getToken];
}

- (void)getToken {
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] get:@"oss/getToken" parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseNewModel.status isEqualToString:@"0000"]) {
            NSDictionary *dic = [[responseNewModel.body valueForKey:@"token"] valueForKey:@"credentials"];
            self.accessKeyId = dic[@"accessKeyId"];
            self.accessKeySecret = dic[@"accessKeySecret"];
            self.securityToken = dic[@"securityToken"];
        } else {
            [KeyWindow displayMessage:responseNewModel.message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

/**
 *  隐藏导航栏
 */
-(void)editNavi{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"个人资料";
    [self setNavigationBarBackgroundImage];
    [self setBackItemWithIcon:nil];
    self.view.backgroundColor = COLOR_BACKGROUND;
}
-(void)createTableView{
    /**
     *  tableView
     */
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 35, 0)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    
}
#pragma mark -- request
-(void)request {    
    NSDictionary * body = @{@"version":SHORT_VERSION,
                            @"device":@"iOS"
                            };
    [[HXNetManager shareManager] post:GetHeaderUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
        if (IsEqualToSuccess(responseNewModel.status)) {
//            if ([responseNewModel.body objectForKey:@"isBinding"]) {
//                if (![[responseNewModel.body objectForKey:@"isBinding"] boolValue]) {
//                    [HXSingletonView signletonView].model = [HXBankDtoModel mj_objectWithKeyValues:[responseNewModel.body objectForKey:@"bankDto"]];
//                    [[HXSingletonView signletonView] creatView];
//                }
//            }
            self.photoUrl = [Helper photoUrl:[responseNewModel.body objectForKey:@"icon"] width:100 height:100];
            [_tableView reloadData];
        }else {
            
        }
    } failure:^(NSError *error) {
       
    }];
}

#pragma mark-tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"IdentityInfoCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
     
    }
    if (indexPath.row == 0 ) {
        [cell creatLine:15 hidden:NO];
        cell.nameLabel.text = @"头像";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //获取APP icon
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageNamed:icon]];
        self.headCell = cell;
    }else {
        cell.nameLabel.text = @"手机号";
        cell.titleLabel.text = [[AppManager manager] getMyPhone].length !=0?[[AppManager manager] getMyPhone]:@"";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    }else {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0) {
        UIActionSheet* action = [[UIActionSheet alloc]
                                 initWithTitle:nil
                                 delegate:self
                                 cancelButtonTitle:@"取消"
                                 destructiveButtonTitle:@"我的相册"
                                 otherButtonTitles:@"拍照",nil];
        action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [action showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
//        我的相册
        [self photo];
    }else if (buttonIndex == 1) {
//        拍照
        [self camera];
    }else if(buttonIndex == 2) {
        NSLog(@"取消");
    }
}
- (void) camera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
//        //设置是否可对图片进行编辑
//        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)photo {
    //1.初始化一个XMNPhotoPickerController
    XMNPhotoPickerController * photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:1 delegate:nil];
    //3..设置选择完照片的block 回调
    __weak typeof(*&self) wSelf = self;
    [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        __weak typeof(*&self) self = wSelf;
        //        double kCompressionQuality = 0.3;
        if (images > 0) {
            self.headCell.headImage.image = [images firstObject];
            [self submitPhotoUrl];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
    }];
    //5.设置用户取消选择的回调 可选
    [photoPickerC setDidCancelPickingBlock:^{
        NSLog(@"photoPickerC did Cancel");
        //此处不需要自己dismiss
    }];
    //6. 显示photoPickerC
    [self presentViewController:photoPickerC animated:YES completion:nil];
}

-(void)submitPhotoUrl {
    NSData *forontData = [UIImage resetSizeOfImageDataWithSourceImage:self.headCell.headImage.image maxSize:600];
    
#warning 参数设置
    NSString *endpoint = @"https://oss-cn-qingdao.aliyuncs.com";
    id<OSSCredentialProvider> credential =  [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.accessKeyId secretKeyId:self.accessKeySecret securityToken:self.securityToken];
    _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = [NSString stringWithFormat:@"%s", bucketNameXXX];
    NSString *objectKeys = [NSString stringWithFormat:@"icon/%@.jpg",[self getTimeNow]];
    put.objectKey = objectKeys;
#warning 参数设置
    //上传方式：文件、数据流
    //put.uploadingFileURL = [NSURL fileURLWithPath:fullPath];
    put.uploadingData = forontData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [_client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [self.client presignPublicURLWithBucketName:[NSString stringWithFormat:@"%s", bucketNameXXX]
                                             withObjectKey:objectKeys];
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
//            NSLog(@"upload object success!");
            NSString *str = task.result;
            NSDictionary *body = @{@"icon":str};
            [[HXNetManager shareManager] post:UploadHeaderUrl parameters:body sucess:^(ResponseNewModel *responseNewModel) {
                if (IsEqualToSuccess(responseNewModel.status)) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_HeadPHoto object:nil userInfo:nil];
                }
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}

/**
 *  返回当前时间
 *
 */
- (NSString *)getTimeNow {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@X%i", date,last];
//    NSLog(@"%@", timeNow);
    return timeNow;
}


// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (image) {
        self.headCell.headImage.image = image;
        [self submitPhotoUrl];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
