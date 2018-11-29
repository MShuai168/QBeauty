//
//  UILabel+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/27.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "UILabel+Category.h"
#import <CoreText/CoreText.h>


@implementation UILabel (Category)

- (void)alignmentLeftTop {
    
    
    CGSize   textSize     = [self.text sizeWithConstrainedSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                                          font:self.font
                                                   lineSpacing:0];
    CGFloat finalHeight   = textSize.height;
    CGFloat finalWidth    = textSize.width;
    
    NSString *text        = @"Height";
    CGSize  stringSize    = [text sizeWithConstrainedSize:CGSizeMake(finalWidth, MAXFLOAT)
                                                     font:self.font
                                              lineSpacing:0];
    
    NSInteger lines       = (self.frame.size.height - finalHeight) / stringSize.height;
    
    for(NSInteger i = 0; i < lines; i++)
        self.text = [self.text stringByAppendingString:@"\n "];

}

- (void)alignmentLeftBottom {
    
    
}

- (void)alignmentBothEnds {
    
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin |
                                                      NSStringDrawingTruncatesLastVisibleLine |
                                                      NSStringDrawingUsesFontLeading
                                           attributes:@{NSFontAttributeName : self.font}
                                              context:nil].size;
    
    CGFloat margin   = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
    
}

@end
