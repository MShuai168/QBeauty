//
//  PickerChoiceView.h
//  PickerView
//
//  Created by Shuai on 2017/4/5.
//  Copyright © 2017年 正盾科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerDelegate <NSObject>
- (void)PickerSelectorIndixString:(NSString *)str;
@optional
- (void)PickerSelectorIndixColour:(UIColor *)color;
@end

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    weightArray,
    deteArray,
    deteAndTimeArray,
    colourArray
};

@interface PickerChoiceView : UIView
//设置类型
@property (nonatomic, assign) ARRAYTYPE arrayType;
//自定义类型
@property (nonatomic, strong) NSArray *customArr;

@property (nonatomic, strong) UILabel *selectLb;
@property (nonatomic, assign) id<PickerDelegate>delegate;
@property (nonatomic, strong) NSString *selectStr;

@end
