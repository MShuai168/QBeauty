//
//  HXScoreProductDetailViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/9/27.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXScoreProductDetailViewController.h"
#import "HXShoppingCartViewController.h"
#import "HXImagePhoto.h"

#import <NYTPhotoViewer/NYTPhoto.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>

@interface HXScoreProductDetailViewController ()

@end

@implementation HXScoreProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    __weak typeof(self) weakSelf = self;
    [self.wkWebView registerHandler:@"Native_Show_Big_Picture" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong __typeof (weakSelf) sself = weakSelf;
        NSArray *imgList = [data objectForKey:@"imgList"];
        NSMutableArray *photos = [NSMutableArray array];
        
        for (NSDictionary *dic in imgList) {
            HXImagePhoto *photo = [[HXImagePhoto alloc] init];
            
            photo.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]]];
            [photos addObject:photo];
        }
        NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:photos];
        [sself presentViewController:photosViewController animated:YES completion:nil];
        
    }];
}

- (void)targetToViewController:(HXWKWebView *)hxWKWebView withData:(id)data block:(WVJBResponseCallback)responseCallback {
    [super targetToViewController:hxWKWebView withData:data block:responseCallback];
}

- (void)dealloc {
    NSLog(@"HXScoreProductDetail dealloc.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
