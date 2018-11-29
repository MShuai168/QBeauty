//
//  HXContentWebViewCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/4.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXContentWebViewCell.h"
@interface HXContentWebViewCell()<UIWebViewDelegate>
@end
@implementation HXContentWebViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
    
}
-(void)creatView {
    [super creatView];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor blueColor];
    self.webView.delegate =self;
    self.webView.userInteractionEnabled =NO;
//    [self.webView setScalesPageToFit:NO];
    [self.contentView addSubview:self.webView];
    
}
-(void)setHtmlStr:(NSString *)htmlStr {
    if (htmlStr.length != 0 && _cellRefreshCount<=1) {
        [self.webView loadHTMLString:htmlStr baseURL:nil];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    //定义JS字符串
    NSString *script = [NSString stringWithFormat: @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var myimg;"
                        "var maxwidth=%f;" //屏幕宽度
                        "for(i=0;i <document.images.length;i++){"
                        "myimg = document.images[i];"
                        "if (myimg.width > (maxwidth-30)) {"
                        "myimg.height = (maxwidth-15) / (myimg.width/myimg.height);"
                        "myimg.width = maxwidth-15;"
                        "}"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('p')[0].appendChild(script);",SCREEN_WIDTH];
    //添加JS
    [webView stringByEvaluatingJavaScriptFromString:script];
    //添加调用JS执行的语句
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    CGRect frame = webView.frame;
    frame.size.width = SCREEN_WIDTH;
    frame.size.height = 1;
    
    //    wb.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height;
    
    NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    webView.frame = frame;
    if (self.delegate == nil) {
        return;
    }
    if (!self.delegate) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        
        [self.delegate webViewDidFinishLoad:webView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
