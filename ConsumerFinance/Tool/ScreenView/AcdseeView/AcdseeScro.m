//
//  AcdseeScro.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/13.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "AcdseeScro.h"
#import "SelectPhotoView.h"
static CGRect oldframe;
@interface AcdseeScro()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@end
@implementation AcdseeScro
-(id)init {
    self = [super init];
    if (self) {
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        self.delegate = self;
    }
    return self;
}
#pragma mark -- 横向滑动图片
-(void)creatAcdsee {
    for (int i = 0; i<4; i++) {
        UIImageView * photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(15+i*105, 15, 90, 70)];
        [photoImage setImage:[UIImage imageNamed:@"timg.jpeg"]];
        photoImage.userInteractionEnabled = YES;
        [self addSubview:photoImage];
        UITapGestureRecognizer * qingpai = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [photoImage addGestureRecognizer:qingpai];
        UIView *singleTapView = [qingpai view];
        singleTapView.tag = i;
        
    }
    self.contentSize = CGSizeMake(15+4*105, 93);
    
}
#pragma mark -- 图片显示
-(void)creatPictureWall {
    
    NSMutableArray * dataArr = [[NSMutableArray alloc] initWithObjects:@"timg.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-3.jpeg", nil] ;
    
    for (int i = 0; i<dataArr.count; i++) {
        int x = i/3;
        int y = i%3;
        float with = (SCREEN_WIDTH - 30)/3;
        UIImageView * photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(15+y*with, x*90, with-4.5, 80)];
        photoImage.backgroundColor = [UIColor blueColor];
        [self addSubview:photoImage];
    }
}
#pragma mark -- 图片点击放大 浏览器
-(void)tapAction:(id)sender {
    UITapGestureRecognizer * qingpai = (UITapGestureRecognizer * )sender;
    NSMutableArray * dataArr = [[NSMutableArray alloc] initWithObjects:@"timg.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-3.jpeg", nil] ;
    SelectPhotoView * photo = [[SelectPhotoView alloc] initWithDataArr:dataArr];
    photo.index = [qingpai view].tag;
    photo.alpha = 0;
    oldframe = [[qingpai view] convertRect:[qingpai view].bounds toView:[UIApplication sharedApplication].keyWindow];
    photo.frame = oldframe;
    [[UIApplication sharedApplication].keyWindow addSubview:photo];
    [UIView animateWithDuration:0.3 animations:^{
        photo.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        photo.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    __block typeof(photo) weakSelf = photo;
    photo.selectDeselect = ^(){
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.frame = oldframe;
            weakSelf.alpha  = 0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            weakSelf = nil;
            
        }];
    };
    
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
