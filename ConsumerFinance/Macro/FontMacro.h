//
//  FontMacro.h
//  QianXiang
//
//  Created by 侯荡荡 on 16/3/23.
//  Copyright © 2016年 JoviJovi. All rights reserved.
//

#ifndef FontMacro_h
#define FontMacro_h


/** 常用字体Macro */
#define FONT_HEITI_LIGHT_SIZE(s)                            [UIFont fontWithName:@"STHeitiSC-Light" size:s]
#define FONT_HEITI_SIZE(s)                                  [UIFont fontWithName:@"STHeitiSC" size:s]
#define FONT_HEITI_MEDIUM_SIZE(s)                           [UIFont fontWithName:@"STHeitiSC-MEDIUM" size:s]

#define FONT_HELVETICA_SIZE(s)                              [UIFont fontWithName:@"Helvetica" size:s]
#define FONT_HELVETICA_BOLD_SIZE(s)                         [UIFont fontWithName:@"Helvetica-Bold" size:s]

#define FONT_HELVETICA_NEUE_SIZE(s)                         [UIFont fontWithName:@"HelveticaNeue" size:s]
#define FONT_HELVETICA_NEUE_BOLD_SIZE(s)                    [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define FONT_HELVETICA_NEUE_LIGHT_SIZE(s)                   [UIFont fontWithName:@"HelveticaNeue-Light" size:s]

#define FONT_BANK_CARD_NUMBER_SIZE(s)                       [UIFont fontWithName:@"Farrington-7B-Qiqi" size:s]
#define FONT_LANTING_SIZE(s)                                [UIFont fontWithName:@"Lantinghei SC" size:s]

#define FONT_SYSTEM_SIZE(s)                                 [UIFont systemFontOfSize:s]
#define FONT_BOLD_SYSTEM_SIZE(s)                            [UIFont boldSystemFontOfSize:s]

#define NormalFontWithSize(size)                            FONT_SYSTEM_SIZE(size)
#define NumberFontWithSize(size)                            FONT_HEITI_LIGHT_SIZE(size)


#endif /* FontMacro_h */
