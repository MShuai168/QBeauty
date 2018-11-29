//
//  HXMessageCell.h
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/5/19.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HXMessageCell : BaseTableViewCell
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UIView * numberView;
@property (nonatomic,strong)UILabel * timeLabel;
@end
