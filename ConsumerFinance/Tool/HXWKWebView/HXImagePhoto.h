//
//  HXImagePhoto.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/10/18.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <NYTPhotoViewer/NYTPhoto.h>

@interface HXImagePhoto : NSObject<NYTPhoto>

@property (nonatomic) UIImage *image;
@property (nonatomic) NSData *imageData;
@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) NSAttributedString *attributedCaptionTitle;
@property (nonatomic) NSAttributedString *attributedCaptionSummary;
@property (nonatomic) NSAttributedString *attributedCaptionCredit;

@end
