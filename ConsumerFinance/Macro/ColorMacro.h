//
//  ColorMacro.h
//  QianXiang
//
//  Created by 侯荡荡 on 16/3/22.
//  Copyright © 2016年 Hou. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

//颜色的RGB值
#define ColorWithRGB(r,g,b)         [UIColor colorWithRGB:r green:g blue:b]

//颜色的RGBA值
#define ColorWithRGBA(r,g,b,a)      [UIColor colorWithRGB:r green:g blue:b alpha:a]

//颜色的Hex值
#define ColorWithHex(hex)           [UIColor colorWithHex:hex]

//颜色的HexA值
#define ColorWithHexA(hex,a)        [UIColor colorWithHex:hex alpha:a]

//随机色
#define ColorRandom                 ColorWithRGB(arc4random_uniform(255.0f),\
                                                 arc4random_uniform(255.0f),\
                                                 arc4random_uniform(255.0f))


//rgb颜色
#define HXRGB(r,g,b)                [UIColor colorWithRed:r/255.0 \
                                                    green:g/255.0 \
                                                     blue:b/255.0 \
                                                    alpha:1.0]
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//默认导航条颜色
#define COLOR_YELLOW_DARK           ColorWithRGB(251.0f,173.0f,42.0f)
//字体深黑
#define COLOR_BLACK_DARK            ColorWithRGB(51.0f,51.0f,51.0f)




//背景色深色
#define COLOR_BACKGROUND_DARK       ColorWithHex(0xeeeff0)
//button可点击
#define COLOR_BUTTON_ENABLE         ColorWithHex(0xe23f39)
//button不可点击
#define COLOR_BUTTON_UNABLE         ColorWithHex(0xdcdcdc)

//字体浅黑
#define COLOR_BLACK_LIGHT           ColorWithHex(0x555555)
//字体深灰
#define COLOR_GRAY_DARK             ColorWithHex(0x838383)
//字体中灰
#define COLOR_GRAY_MEDIUM           ColorWithHex(0xb3b5bd)
//字体浅灰
#define COLOR_GRAY_LIGHT            ColorWithHex(0xe8e9ea)
//红色
#define COLOR_RED_DARK              ColorWithHex(0xe23f39)
//浅红
#define COLOR_RED_LIGHT             ColorWithHex(0xf6c6c5)
//tabbar背景色
#define COLOR_GRAY_TABBAR           ColorWithHex(0xf8f8f9)
//tabbar未选中字体颜色
#define COLOR_BLACK_TABBAR          ColorWithHex(0xb2b2b2)
//淡白
#define COLOR_WHITE_LIGHT           ColorWithHex(0xf5f5f5)
//浅白
#define COLOR_WHITE_TINT            ColorWithHex(0xf7f7f7)
//默认白
#define COLOR_DEFAULT_WHITE         [UIColor whiteColor]
//默认黑
#define COLOR_DEFAULT_BLACK         [UIColor blackColor]

#define COLOR_BLUE_DARK             ColorWithRGB(60, 155, 255)

#define COLOR_PLACEHOLDER           ColorWithHex(0x519500)

//项目背景色
#define COLOR_DEFAULT_BACKGROUND    ColorWithRGB(236.0f,241.0f,244.0f)

#define COLOR_HM_BLACK              ColorWithRGB(51.0f,51.0f,51.0f)

#define COLOR_HM_DARK_GRAY          ColorWithRGB(102.0f,102.0f,102.0f)

#define COLOR_HM_GRAY               ColorWithRGB(170.0f,170.0f,170.0f)

#define COLOR_BACKGROUND            kUIColorFromRGB(0xF5F7F8)

#define CellLineColor               HXRGB(221, 221, 221)

#define ComonBackColor              kUIColorFromRGB(0xFF6BA7)

#define ComonCharColor              kUIColorFromRGB(0x999999)

#define ComonTextColor              kUIColorFromRGB(0x333333)

#define ComonTitleColor              kUIColorFromRGB(0x666666)

#define CommonBackViewColor         kUIColorFromRGB(0xffffff)

#define CommonBlackColor            kUIColorFromRGB(0xcccccc)
#endif /* ColorMacro_h */
