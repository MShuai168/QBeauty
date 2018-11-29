//
//  DKSetTradeView.m
//  HSMC
//
//  Created by Metro on 16/7/30.
//  Copyright © 2016年 Dalvik. All rights reserved.
//

#import "DKSetTradeView.h"

#define kScreenUnit_W [UIScreen mainScreen].bounds.size.width/375.0f
#define kScreenUnit_H [UIScreen mainScreen].bounds.size.height/667.0f
@interface DKSetTradeView ()<UITextFieldDelegate>

@property (nonatomic,copy) DKSetTradePasswordValue completion;


@end

@implementation DKSetTradeView

- (instancetype)initWithTitle:(NSString *)title completion:(DKSetTradePasswordValue)completion{
    
    
    self = [super initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    if (self) {
        
        _completion = completion;
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH - 20, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = title;
        [self addSubview:label];
        
        _inputTextFiled = ({
            
            UITextField *textField  = [[UITextField alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 44)];
            textField.backgroundColor = [UIColor clearColor];
            textField.layer.masksToBounds = YES;
            textField.secureTextEntry = YES;
            textField.delegate = self;
            textField.tintColor = [UIColor clearColor];//看不到光标
            textField.textColor = [UIColor clearColor];//看不到输入内容
            textField.font = [UIFont systemFontOfSize:30];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            [textField addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
            [self addSubview:textField];
            textField;
        });
        
        [self textFieldAddSubview];
        
    }
    return self;
}

#pragma mark 监听textField的值改变事件
- (void)textFiledEdingChanged {
    NSInteger length = self.inputTextFiled.text.length;
    NSLog(@"%ld", length);
    if (length == kPasswordLength) {
        
        [self endEditing:YES];
        if (self.completion) {
            self.completion(self.inputTextFiled.text);
        }
    }
    for(NSInteger i=0;i<kPasswordLength;i++){
        UILabel *dotLabel = (UILabel *)[self.inputTextFiled viewWithTag:kDotTag + i];
        if(dotLabel){
            dotLabel.hidden = length <= i;
        }
      
    }
    
}

-(void)cancelPassword{
    
    for(NSInteger i=0;i<kPasswordLength;i++){
        UILabel *dotLabel = (UILabel *)[self.inputTextFiled viewWithTag:kDotTag + i];
        if(dotLabel){
            dotLabel.hidden = YES;
        }
        
    }
    
}


- (void)textFieldAddSubview {
    
    CGFloat width = (SCREEN_WIDTH - 30*kScreenUnit_W)/6;
    
    for(NSInteger i=0;i<kPasswordLength;i++){
        
        if(i < kPasswordLength ){
            
            UIView *view = (UIView *)[self.inputTextFiled viewWithTag:kLineTag + i];
            if (!view) {
                view = [[UIView alloc] init];
                view.tag = kLineTag + i;
                view.layer.borderWidth = 0.5;
                view.layer.borderColor = kUIColorFromRGB(0xDDDDDD).CGColor;
                [self.inputTextFiled addSubview:view];
            }
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(giveUpFirstRespond)];
            tapGesture.numberOfTouchesRequired = 1;
            tapGesture.numberOfTapsRequired = 1;
            [view addGestureRecognizer:tapGesture];
            
            view.frame = CGRectMake((width - width/2 + 15*kScreenUnit_W - 22) + width*i, 0, 44, 44);
            view.backgroundColor = kUIColorFromRGB(0xEFEFEF);
        }
        
        
        UILabel *dotLabel = (UILabel *)[self.inputTextFiled viewWithTag:kDotTag + i];
        if(!dotLabel){
            dotLabel = [[UILabel alloc]init];
            dotLabel.tag = kDotTag + i;
            [self.inputTextFiled addSubview:dotLabel];
        }
        dotLabel.frame = CGRectMake((width - width/2 + 15*kScreenUnit_W - 5) + width*i, 22-5, 10, 10);
        dotLabel.layer.masksToBounds = YES;
        dotLabel.layer.cornerRadius = 5;
        dotLabel.backgroundColor = [UIColor blackColor];
        dotLabel.hidden = YES;
    }
    
 
    
}

- (void)giveUpFirstRespond{
    
    [self.inputTextFiled becomeFirstResponder];
    
}

- (void)dealloc {
    [self.inputTextFiled removeTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
}


//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController){
        menuController.menuVisible = NO;
    }
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}




@end
