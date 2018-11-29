//
//  AddressPickViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/22.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "AddressPickViewController.h"
#import <Masonry/Masonry.h>

@interface AddressPickViewController ()

@end

@implementation AddressPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    
    AddressWithZonesPickView *addressWithZonePickView = [AddressWithZonesPickView shareInstanceWithAnimate:NO];
    
    [self.view addSubview:addressWithZonePickView];
    [addressWithZonePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) weakSelf = self;
    addressWithZonePickView.block = ^(AddressModel *provinceModel, AddressModel *cityModel, AddressModel *zoneModel) {
        __strong __typeof (weakSelf) sself = weakSelf;
        if (sself.block) {
            sself.block(provinceModel, cityModel, zoneModel);
        }
        [sself dismissViewControllerAnimated:YES completion:nil];
    };
    
    addressWithZonePickView.dismiss = ^{
        __strong __typeof (weakSelf) sself = weakSelf;
        [sself dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self _addTapGestureRecognizerToSelf];
}

- (void)_addTapGestureRecognizerToSelf {
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self.view addGestureRecognizer:tap];
}

- (void)hiddenBottomView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"AddressPickViewController dealloc");
}

@end
