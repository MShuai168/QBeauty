////
////  HXImageUploadViewController.m
////  ConsumerFinance
////
////  Created by 孟祥群 on 2017/4/24.
////  Copyright © 2017年 Hou. All rights reserved.
////
//
//#import "HXImageUploadViewController.h"
//#import "SelectPhotoView.h"
//#import "XMNPhotoPickerController.h"
//#import "ComButton.h"
//#import "HXHomeInformationViewController.h"
//#import "HXCertificationViewModel.h"
//#import "DataAuthenticationViewController.h"
//
//#import "JCKeyBoardNum.h"
//#import "UITextField+JCTextField.h" // 自定义数字键盘
//#import "HXBillingdetailsViewController.h"
//#import "HXSecurityViewController.h"
//#import "HXIdCardVerificationViewController.h"
//#import "CertificationViewController.h"
//
//#define deletePhotoTag 500
//@interface HXImageUploadViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate>
//{
//    UITableView *_tableView;
//}
//@property (nonatomic,strong)UICollectionView *collectionView;
//@property (nonatomic,strong)NSMutableArray * photoArr;
//@property (nonatomic,strong)BaseTableViewCell * nameCell;
//@property (nonatomic,strong)BaseTableViewCell * idCardCell;
//@property (nonatomic, strong) JCKeyBoardNum *NumKeyBoard;
//
//@property (nonatomic,strong)HXCertificationViewModel * viewModel;
//@property (nonatomic,strong) UIButton * referButton;
//@end
//
//@implementation HXImageUploadViewController
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.viewModel = [[HXCertificationViewModel alloc] initWithController:self];
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self editNavi];
//    [self createUI];
//    [self hiddeKeyBoard];
//}
///**
// *  导航栏
// */
//-(void)editNavi{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.title = @"影像上传";
//    [self setNavigationBarBackgroundImage];
//    [self setBackItemWithIcon:nil];
//    self.view.backgroundColor = COLOR_BACKGROUND;
//}
//-(void) hiddeKeyBoard{
//    
//    [self.view endEditing:YES];
//    
//}
//-(void)createUI {
//    /**
//     *  tableView
//     */
//    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_tableView];
//    _tableView.scrollEnabled = NO;
//    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(10);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.height.mas_equalTo(100);
//        
//    }];
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.font = [UIFont systemFontOfSize:13];
//    titleLabel.numberOfLines = 0;
//    titleLabel.textColor = ComonCharColor ;
//    titleLabel.text = @"请上传凭证：临时身份证（正反面）、户口簿（首页和本人页）";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.width.mas_equalTo(SCREEN_WIDTH-30);
//        make.height.mas_equalTo(43);
//        make.top.equalTo(_tableView.mas_bottom).offset(13.5);
//    }];
//    
//    UIButton * referButton = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT-129, SCREEN_WIDTH-30, 50)];
//    [referButton setTitle:@"保存" forState:UIControlStateNormal];
//    self.referButton  = referButton;
//    self.referButton.enabled = NO;
//    referButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [referButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    [referButton.layer setMasksToBounds:YES];
//    [referButton.layer setCornerRadius:4];
//    [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:referButton style:UIControlStateNormal];
//    [Helper createImageWithColor:[kUIColorFromRGB(0x56A0FC) colorWithAlphaComponent:0.7] button:referButton style:UIControlStateHighlighted];
//    [self.view addSubview:referButton];
//    
//    
//    [self creatCollectionview];
//}
//-(void)creatCollectionview {
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.itemSize = CGSizeMake((SCREEN_WIDTH-70)/2, 115);
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumLineSpacing = 10;
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(30, 173.5, SCREEN_WIDTH-60,SCREEN_HEIGHT-173.5-64-75) collectionViewLayout:layout];
//    _collectionView = collectionView;
//    collectionView.backgroundColor = COLOR_BACKGROUND;
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    collectionView.scrollsToTop = NO;
//    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"idenOne"];
//    [self.view addSubview:collectionView];
//    
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.photoArr.count +1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (((indexPath.row - _photoArr.count)==0) || _photoArr.count == 0 ) {
//        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idenOne" forIndexPath:indexPath];
//        cell.contentView.backgroundColor = kUIColorFromRGB(0x55A0FC);
//        /**
//         *  icon
//         *
//         */
//        UIImageView * image = [[UIImageView alloc] init];
//        [image setImage:[UIImage imageNamed:@"takephoto"]];
//        image.contentMode = UIViewContentModeScaleAspectFit;
//        [cell.contentView addSubview:image];
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(cell.contentView);
//            make.top.equalTo(cell.contentView).offset(15);
//            make.height.mas_equalTo(70);
//            make.width.mas_equalTo(110);
//        }];
//        /**
//         *  标题
//         *
//         */
//        UILabel * titleLabel = [[UILabel alloc] init];
//        titleLabel.text = @"上传凭证";
//        titleLabel.adjustsFontSizeToFitWidth = YES;
//        titleLabel.textColor= kUIColorFromRGB(0xffffff);
//        titleLabel.font = [UIFont systemFontOfSize:14];
//        [cell.contentView addSubview:titleLabel];
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(cell.contentView);
//            make.top.equalTo(image.mas_bottom).offset(10);
//        }];
//        return cell;
//        
//    }else {
//        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
//        UIImageView * photoImage  = [[UIImageView alloc] init];
//        photoImage.image = [self.photoArr objectAtIndex:indexPath.row];
//        [cell.contentView addSubview:photoImage];
//        [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.and.bottom.and.left.and.right.equalTo(cell.contentView);
//        }];
//        
//        UIButton * deleteButton  = [[UIButton alloc] init];
//        deleteButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//        deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        deleteButton.tag = indexPath.row + deletePhotoTag;
//        [deleteButton addTarget:self action:@selector(delegateAction:) forControlEvents:UIControlEventTouchUpInside];
//        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//        [cell.contentView addSubview:deleteButton];
//        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(cell.contentView);
//            make.left.and.right.equalTo(cell.contentView);
//            make.height.mas_equalTo(30);
//        }];
//        return cell;
//    }
//}
//#pragma mark-tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdentity = @"IdentityInfoCell";
//    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    if (!cell) {
//        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
//        [cell creatLine:15 hidden:NO];
//    }
//    cell.writeTextfield.tag = indexPath.row +1;
//    cell.writeTextfield.delegate =self;
//    if (indexPath.row == 0) {
//        cell.nameLabel.text = @"真实姓名";
//        cell.writeTextfield.placeholder = @"请输入真实姓名";
//        cell.writeTextfield.text = self.nameStr.length?self.nameStr:@"";
//        [cell.writeTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        self.nameCell = cell;
//    }else {
//        cell.nameLabel.text = @"身份证号";
//        cell.writeTextfield.placeholder = @"请输入身份证号";
//        cell.writeTextfield.text = self.idCardNumber.length?self.idCardNumber:@"";
//        self.idCardCell = cell;
//    }
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 50;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.1;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"BtnClick_%zd",indexPath.row);
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    //    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //    NSMutableArray * dataArr = [[NSMutableArray alloc] initWithObjects:@"test01.jpeg",@"test01.jpeg",@"test01.jpeg",@"test01.jpeg",@"test01.jpeg", nil] ;
//    //    SelectPhotoView * photo = [[SelectPhotoView alloc] initWithDataArr:dataArr];
//    //    photo.index = indexPath.row;
//    //    photo.alpha = 0;
//    //    oldframe = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
//    //    photo.frame = oldframe;
//    //    [[UIApplication sharedApplication].keyWindow addSubview:photo];
//    //    [UIView animateWithDuration:0.3 animations:^{
//    //        photo.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    //        photo.alpha = 1;
//    //    } completion:^(BOOL finished) {
//    //
//    //    }];
//    //
//    //    __block typeof(photo) weakSelf = photo;
//    //    photo.selectDeselect = ^(){
//    //        [UIView animateWithDuration:0.3 animations:^{
//    //            weakSelf.frame = oldframe;
//    //            weakSelf.alpha  = 0;
//    //        } completion:^(BOOL finished) {
//    //            [weakSelf removeFromSuperview];
//    //            weakSelf = nil;
//    //
//    //        }];
//    //    };
//    [self.view endEditing:YES];
//    if (self.photoArr.count == 2) {
//        [KeyWindow displayMessage:@"最多选择2张图片"];
//        return;
//    }
//    UIActionSheet* action = [[UIActionSheet alloc]
//                             initWithTitle:nil
//                             delegate:self
//                             cancelButtonTitle:@"取消"
//                             destructiveButtonTitle:@"我的相册"
//                             otherButtonTitles:@"拍照",nil];
//    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    
//    [action showInView:self.view];
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //    [textField keyBoardEvent];
//}
//#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (textField == self.idCardCell.writeTextfield) {
//        self.NumKeyBoard = [JCKeyBoardNum show];
//        textField.inputView = self.NumKeyBoard;
//        __weak typeof(self) weakSelf = self;
//        //点击键盘
//        self.NumKeyBoard.completeBlock = ^(NSString *text,NSInteger tag) {
//            switch (tag) {
//                case 9:
//                    if (weakSelf.idCardCell.writeTextfield.text.length!=0 &&![weakSelf.idCardCell.writeTextfield.text containsString:@"X"]&&weakSelf.idCardCell.writeTextfield.text.length==17 ) {
//                        
//                        [weakSelf.idCardCell.writeTextfield changTextWithNSString:@"X"];
//                    }
//                    break;
//                case 11:
//                    //点击删除按钮
//                    [weakSelf clickDeleteBtn];
//                    break;
//                default:
//                    //点击数字键盘
//                    [weakSelf.idCardCell.writeTextfield changTextWithNSString:text];
//                    break;
//            }
//            [weakSelf changeButtonStates];
//        };
//    }
//    return YES;
//}
//- (void)clickDeleteBtn
//{
//    if (self.idCardCell.writeTextfield.text.length > 0) {
//        self.idCardCell.writeTextfield.text = [self.idCardCell.writeTextfield.text substringToIndex:self.idCardCell.writeTextfield.text.length - 1];
//    }
//}
//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if ([textField isEqual:_nameCell.writeTextfield]) {
//        
//    }
//    
//    [self changeButtonStates];
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSInteger allowedLength = 100;
//    NSString  *astring      = @"";
//    
//    
//    switch (textField.tag) {
//        case 1: {
//            allowedLength = 12;
//            //            astring       = LIMIT_ALPHANUM;
//        }
//            break;
//        case 2: {
//            allowedLength = 18;
//        }
//            break;
//        case 5: {
//            allowedLength = 13;
//            astring       = LIMIT_NUMBERS;
//            if (textField.text.length==4&&string.length!=0) {
//                
//                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
//    if ([NSString isBlankString:astring]) {
//        if ([textField.text length] < allowedLength || [string length] == 0) {
//            return YES;
//        }else {
//            [textField shakeAnimation];
//            return NO;
//        }
//    } else {
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:astring] invertedSet];
//        //按cs分离出数组,数组按@""分离出字符串
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL canChange     = [string isEqualToString:filtered];
//        
//        if ((canChange && [textField.text length] < allowedLength) || [string length] == 0) {
//            return YES;
//        }else {
//            [textField shakeAnimation];
//            return NO;
//        }
//    }
//    
//}
//#pragma mark -- 提交
//-(void)registerAction {
//    if (_nameCell.writeTextfield.text.length==0) {
//        [KeyWindow displayMessage:@"请输入姓名"];
//        return;
//    }
//    if (_idCardCell.writeTextfield.text.length == 0) {
//        [KeyWindow displayMessage:@"请输入身份证号"];
//        return;
//    }
//    if (![Helper justIdentityCard:_idCardCell.writeTextfield.text]) {
//        [KeyWindow displayMessage:@"请输入正确的身份证号码"];
//        return;
//    }
//    if (_photoArr.count <1) {
//        [KeyWindow displayMessage:@"请选择图像证明"];
//        return;
//    }
//    [_viewModel cheakNameAndIdWithName:self.nameCell.writeTextfield.text idcard:self.idCardCell.writeTextfield.text ReturnValue:^{
//        [self submitIDInformation];
//    }];
//    
//}
//-(void)submitIDInformation {
//    UIImage * frontImage;
//    UIImage * backImage;
//    if (self.photoArr.count>0) {
//        frontImage = [self.photoArr firstObject];
//    }
//    if (self.photoArr.count>1) {
//        backImage = [self.photoArr lastObject];
//    }
//    
//    [_viewModel submitCertificationWithName:self.nameCell.writeTextfield.text idcard:self.idCardCell.writeTextfield.text  returnBlock:^{
//        [KeyWindow displayMessage:@"认证成功"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Authentication object:nil userInfo:nil];
//        
//        for (UIViewController *temp in self.navigationController.viewControllers) {
//            if ([temp isKindOfClass:[HXBillingdetailsViewController class]]) {
//                [self.navigationController popToViewController:temp animated:YES];
//                return ;
//            }
//        }
//        for (UIViewController *temp in self.navigationController.viewControllers) {
//            if ([temp isKindOfClass:[HXSecurityViewController class]]) {
//                HXIdCardVerificationViewController * card = [[HXIdCardVerificationViewController alloc] init];
//                [self.navigationController pushViewController:card animated:YES];
//                
//                NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
//                for (UIViewController *vc in marr) {
//                    if ([vc isKindOfClass:[CertificationViewController class]]) {
//                        [marr removeObject:vc];
//                        continue;
//                    }
//                    if ([vc isKindOfClass:[HXImageUploadViewController class]]) {
//                        [marr removeObject:vc];
//                        continue;
//                    }
//                }
//                self.navigationController.viewControllers = marr;
//                return ;
//            }
//        }
//        
//        for (UIViewController * controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[DataAuthenticationViewController class]]) {
//                DataAuthenticationViewController *loanProduct = (DataAuthenticationViewController *)controller;
//                [self.navigationController popToViewController:loanProduct animated:YES];
//                return ;
//            }
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    
//}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        NSLog(@"进入相册");
//        [self photo];
//        
//    }else if (buttonIndex == 1) {
//        [self camera];
//    }else if(buttonIndex == 2) {
//        NSLog(@"取消");
//    }
//}
//- (void) camera
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
//        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
//        imagePicker.delegate = self;
//        //        _imagePicker.allowsEditing = YES;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//        
//    }
//    
//}
//- (void)photo
//{
//    //1.初始化一个XMNPhotoPickerController
//    XMNPhotoPickerController * photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:2-self.photoArr.count delegate:nil];
//    
//    //3..设置选择完照片的block 回调
//    __weak typeof(*&self) wSelf = self;
//    [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
//        __weak typeof(*&self) self = wSelf;
//        double kCompressionQuality = 0.3;
//        if (images > 0) {
//            [self.photoArr addObjectsFromArray:images];
//            [_collectionView reloadData];
//        }
//        [self changeButtonStates];
//        [self dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
//    }];
//    //5.设置用户取消选择的回调 可选
//    [photoPickerC setDidCancelPickingBlock:^{
//        NSLog(@"photoPickerC did Cancel");
//        //此处不需要自己dismiss
//    }];
//    
//    //6. 显示photoPickerC
//    [self presentViewController:photoPickerC animated:YES completion:nil];
//    
//}
//// 选中照片
//- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    
//    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    if (image) {
//        [self.photoArr addObject:image];
//        [_collectionView reloadData];
//    }
//    [self changeButtonStates];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//
//// 取消相册
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}
//#pragma mark -- 判断按钮状态
//-(void)changeButtonStates {
//    if (_nameCell.writeTextfield.text.length!=0&&_idCardCell.writeTextfield.text.length !=0 &&self.photoArr.count !=0 ) {
//        _referButton.enabled = YES;
//        [Helper createImageWithColor:kUIColorFromRGB(0x56A0FC) button:_referButton style:UIControlStateNormal];
//    }else {
//        
//        _referButton.enabled = NO;
//        [Helper createImageWithColor:kUIColorFromRGB(0xCCCCCC) button:_referButton style:UIControlStateNormal];
//    }
//    
//    
//}
//#pragma mark -- 删除图片
//-(void)delegateAction:(id)sender {
//    ComButton * button = (ComButton *)sender;
//    [self.photoArr removeObjectAtIndex:(button.tag-deletePhotoTag)];
//    [_collectionView reloadData];
//    
//}
//#pragma mark -- setter and getter
//-(NSMutableArray *)photoArr {
//    if (_photoArr == nil) {
//        _photoArr = [[NSMutableArray alloc] init];
//    }
//    return _photoArr;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
