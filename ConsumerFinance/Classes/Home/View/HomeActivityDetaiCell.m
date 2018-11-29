//
//  HomeActivityDetaiCell.m
//  ConsumerFinance
//
//  Created by Shuai on 2018/6/5.
//  Copyright © 2018年 ConsumerFinance. All rights reserved.
//

#import "HomeActivityDetaiCell.h"

@implementation HomeActivityDetaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)configCellWithModel:(HomeActivityDetailModel *)model {
//    
//    NSString *userAgent = @"";
//    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
//    
//    if (userAgent) {
//        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
//            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
//            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
//                userAgent = mutableUserAgent;
//            }
//        }
//        [[SDWebImageDownloader sharedDownloader] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//    }
//    
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"错误信息:%@",error);
//    }];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
