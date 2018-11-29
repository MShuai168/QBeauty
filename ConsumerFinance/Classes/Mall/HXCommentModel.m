//
//  HXCommentModel.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/3/15.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXCommentModel.h"
#define UILABEL_LINE_SPACE 2
#define defaultHeight 100
@implementation HXCommentModel
-(void)adjustModel:(NSDictionary *)dic {
//    self.titleHeight = [Helper heightOfString:self.content font:[UIFont systemFontOfSize:13] width:SCREEN_WIDTH-85]+1;
    self.titleHeight = [self getSpaceLabelHeight:self.content withFont:[UIFont systemFontOfSize:13] withWidth:SCREEN_WIDTH-85]+1;
    if (self.titleHeight>defaultHeight) {
        self.contentLength = YES;
    }else {
        self.contentLength = NO;
    }
    self.photoArr = [[NSMutableArray alloc] init];
    if ([dic objectForKey:@"imgList"]) {
        [self.photoArr addObjectsFromArray:[dic objectForKey:@"imgList"]];
    }
    if (self.photoArr.count==0) {
        self.photoHeight = 0;
    }else {
        if (self.photoArr.count%3==0) {
            self.photoHeight = self.photoArr.count/3*80 + (self.photoArr.count/3-1)*9;
        }else {
            self.photoHeight = ((int)(self.photoArr.count/3)+1)*80 + (int)(self.photoArr.count/3)*9;
        }
    }
    NSInteger height = self.contentLength?self.photoArr.count==0?20:36:0;
    NSInteger heightLength =self.contentLength ?defaultHeight:self.titleHeight;
    self.cellHeight = 65+heightLength+self.photoHeight+ height+10;
    
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    
    CGRect bounds;
//    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = bounds.size.height+1;
//    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return height;
}
@end
