//
//  AcdseeCollection.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "AcdseeCollection.h"
#import "SelectPhotoView.h"
#import "AcdSeeCollectionViewCell.h"
static CGRect oldframe;
@interface AcdseeCollection()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray * photoArr;
@end
@implementation AcdseeCollection
-(id)init {
    self = [super init];
    if (self) {
        [self creatCollectionview];
    }
    return self;
}
-(void)creatCollectionview {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(90, 70);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 12.5;
    [layout setHeaderReferenceSize:CGSizeMake(15, 0)];
    [layout setFooterReferenceSize:CGSizeMake(15, 0)];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH,70) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[AcdSeeCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [self addSubview:collectionView];
    
}
-(void)creatSectionCollection:(float)height {
    if (self.collectionView==nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-105)/3, 80);
        layout.minimumInteritemSpacing = 9;
        layout.minimumLineSpacing = 9;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH-85,height) collectionViewLayout:layout];
        self.collectionView = collectionView;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[AcdSeeCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
        [self addSubview:collectionView];
    }
    self.collectionView.frame = CGRectMake(70, 0, SCREEN_WIDTH-85, height);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AcdSeeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.url = [self.photoArr objectAtIndex:indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    SelectPhotoView * photo = [[SelectPhotoView alloc] initWithDataArr:self.photoArr];
    photo.index = indexPath.row;
    photo.alpha = 0;
    oldframe = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
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
-(void)setImageArr:(NSMutableArray *)imageArr {
    [self.photoArr removeAllObjects];
    [self.photoArr addObjectsFromArray:imageArr];
    [_collectionView reloadData];
}
-(NSMutableArray *)photoArr {
    if (_photoArr==nil) {
        _photoArr = [[NSMutableArray alloc] init];
    }
    return _photoArr;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
