//
//  MediaTableViewCell.h
//  creditor
//
//  Created by Jney on 16/9/24.
//  Copyright © 2016年 Jney. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MediaTableViewCell : UITableViewCell



@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIImage *image;
@property(nonatomic,assign) NSInteger      *index;
@property (nonatomic,strong) NSString *imageStream;
@property (nonatomic,strong) NSString *imagePageID;



@end
