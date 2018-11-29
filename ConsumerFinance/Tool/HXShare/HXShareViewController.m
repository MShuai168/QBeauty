//
//  HXShareViewController.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/11/9.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXShareViewController.h"

#import <Weibo_SDK/WeiboSDK.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface HXShareViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) WBMessageObject *messageObject;
@property (nonatomic, strong) HXShareModel *model;

@end

@implementation HXShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
    [self.view addGestureRecognizer:panGesture];
    
    [self request];
}

- (void)setUpView {
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(194);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *cancelButton = [[UIButton alloc] init];
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundColor:ColorWithHex(0xf9f9f9)];
        [cancelButton setTitleColor:ColorWithHex(0x666666) forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_bgView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_bgView);
            make.height.mas_equalTo(50);
        }];
        
        for (int i=0; i<2; i++) {
            UIView *view = [[UIView alloc] init];
            view.tag = i;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
            [view addGestureRecognizer:tapGestureRecognizer];
            
            int width = SCREEN_WIDTH/2;
            [view setFrame:CGRectMake(width*i, 35, width, 74)];
            [_bgView addSubview:view];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            UIImage *image = nil;
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = ColorWithHex(0x666666);
            switch (i) {
                case 0:
                    image = [UIImage imageNamed:@"wechat"];
                    label.text = @"微信";
                    break;
                case 1:
                    image = [UIImage imageNamed:@"friend"];
                    label.text = @"朋友圈";
                    break;
//                case 2:
//                    image = [UIImage imageNamed:@"QQ"];
//                    label.text = @"QQ";
//                    break;
//                case 3:
//                    image = [UIImage imageNamed:@"qqzone"];
//                    label.text = @"空间";
//                    break;
//                case 4:
//                    image = [UIImage imageNamed:@"weibo"];
//                    label.text = @"微博";
//                    break;
                    
                default:
                    break;
            }
            imageView.image = image;
            [view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view);
                make.top.equalTo(view);
                make.size.mas_equalTo(image.size);
            }];
            
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view);
                make.top.equalTo(imageView.mas_bottom).offset(15);
                make.width.equalTo(imageView);
                make.bottom.equalTo(view);
            }];
        
        }
    }
    return _bgView;
}

- (void)cancelButtonClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapView:(UITapGestureRecognizer *)obj {
    switch (obj.view.tag) {
        case 0: {
            //微信
            NSLog(@"微信");
            [self wechatShare:WXSceneSession];
        }
            break;
        case 1: {
            //朋友圈
            NSLog(@"朋友圈");
            [self wechatShare:WXSceneTimeline];
        }
            break;
//        case 2: {
//            //QQ
//            NSLog(@"QQ");
//            [self qqShare:0];
//        }
//            break;
//        case 3: {
//            //空间
//            NSLog(@"空间");
//            [self qqShare:1];
//        }
//            break;
//        case 4: {
//            //微博
//            NSLog(@"微博");
//            [self weiboShare];
//        }
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
#pragma mark - weibo

- (void)weiboShare {
    if (![WeiboSDK isCanShareInWeiboAPP]) {
        [KeyWindow displayMessage:@"请先安装微博"];
        return;
    }
    _messageObject = [self messageToShare];
    [self messageShare];
}
    
-(void)messageShare {
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:_messageObject authInfo:authRequest access_token:nil];
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
}
    
- (WBMessageObject *)messageToShare {
    WBMessageObject *message = [WBMessageObject message];
    
    NSString *text = [NSString stringWithFormat:@"%@%@%@",self.model.title,self.model.text,[NSString stringWithFormat:@"%@&channelType=5",self.model.url]];
    message.text = text;
    
    WBImageObject *image = [WBImageObject object];
    
    if (![NSString isBlankString:self.model.imgUrl]) {
        image.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgUrl]];
    } else {
        image.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon"]);
    }
    
    message.imageObject = image;
    
    return message;
}

#pragma mark - wechat

- (void)wechatShare:(int)scene {
    
    if([WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.model.title;
        message.description = self.model.text;
        
        if (![NSString isBlankString:self.model.imgUrl]) {
            [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgUrl]]]];
        } else {
            [message setThumbImage:[UIImage imageNamed:@"AppIcon"]];
        }
        
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        switch (scene) {
            case WXSceneSession:
                webpageObject.webpageUrl = [NSString stringWithFormat:@"%@&channelType=1",self.model.url];
                break;
            case WXSceneTimeline:
                webpageObject.webpageUrl = [NSString stringWithFormat:@"%@&channelType=2",self.model.url];
                break;
                
            default:
                break;
        }
        message.mediaObject = webpageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
        [WXApi sendReq:req];
    } else {
        [KeyWindow displayMessage:@"请先安装微信"];
    }
}
    
#pragma mark - qq
    
- (void)qqShare:(int)type {
    
    if (![QQApiInterface isQQSupportApi]) {
        [KeyWindow displayMessage:@"请先安装QQ"];
        return;
    }
    //分享跳转URL
    NSString *url = @"";
    
    switch (type) {
        case 0:
            url = [NSString stringWithFormat:@"%@&channelType=3",self.model.url];
            break;
        case 1:
            url = [NSString stringWithFormat:@"%@&channelType=4",self.model.url];
            break;
            
        default:
            break;
    }

    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:self.model.title description:self.model.text previewImageData:![NSString isBlankString:self.model.imgUrl]?[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgUrl]]: UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon"])];

    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    if(type == 0) {
        //将内容分享到qq
        [QQApiInterface sendReq:req];
    } else {
        //将内容分享到qzone
        [QQApiInterface SendReqToQZone:req];
    }
}
    
- (void)request {
    [MBProgressHUD showMessage:nil toView:self.view];
    [[HXNetManager shareManager] get:GetCodeUrl parameters:nil sucess:^(ResponseNewModel *responseNewModel) {
        [MBProgressHUD hideHUDForView:self.view];
        if (IsEqualToSuccess(responseNewModel.status)) {
            [self setUpView];
            self.model = [HXShareModel mj_objectWithKeyValues:responseNewModel.body];
            self.model.title = [NSString isBlankString:self.model.title]?@"TF断货？不存在的！":self.model.title;
            self.model.text = [NSString isBlankString:self.model.text]?@"比价海淘，叫板电商！蔻蓓丽绮，你值得拥有！":self.model.text;
        }else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
         [MBProgressHUD hideHUDForView:self.view];
    }];
    
    
}
    
- (void)dismissView:(id)obj {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"HXShareViewController dealloc.");
}

@end

@implementation HXShareModel

@end
