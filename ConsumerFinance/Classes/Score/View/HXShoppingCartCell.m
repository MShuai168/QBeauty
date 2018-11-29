//
//  HXShoppingCartCell.m
//  ConsumerFinance
//
//  Created by 孟祥群 on 2017/9/13.
//  Copyright © 2017年 ConsumerFinance. All rights reserved.
//

#import "HXShoppingCartCell.h"
#import "ComButton.h"
#import "StrikeThroughLabel.h"
#define NUM @"0123456789"
@interface HXShoppingCartCell()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * numberTextField;
@property (nonatomic,strong)ComButton * selectAllBtn;
@property (nonatomic,strong)HXShopCarModel * shopModel;
@property (nonatomic,strong)ComButton * subtractBtn;
@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * informationLabel;
@property (nonatomic,strong)UILabel * stockLabel;
@property (nonatomic,strong)UIView * calculateView;
@property (nonatomic,strong)UIImageView * shopStatesImage;
@property (nonatomic,strong)ComButton * addShopBtn;
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)StrikeThroughLabel * priceLabel;
@property (nonatomic,strong)UILabel * stockHaveLabel;
@property (nonatomic,strong)UILabel * sclabel;
@end
@implementation HXShoppingCartCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    
    return self;
}
-(void)creatView {
    [super creatView];
    UIImageView * photoImage = [[UIImageView alloc] init];
    self.photoImage = photoImage;
    self.photoImage.layer.borderWidth = 0.5;
    self.photoImage.layer.borderColor = kUIColorFromRGB(0xE5E5E5).CGColor;
//    photoImage.layer.cornerRadius = 10;
//    photoImage.layer.masksToBounds = YES;
    [self.contentView addSubview:photoImage];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView).offset(-12);
        make.left.equalTo(self.contentView).offset(44);
        make.width.mas_equalTo(100);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    titleLabel.textColor = ComonTextColor;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(12);
        make.right.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_lessThanOrEqualTo(40);
    }];
    
    UILabel * informationLabel = [[UILabel alloc] init];
    self.informationLabel = informationLabel;
    informationLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:informationLabel];
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(12);
        make.right.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(60);
        make.height.mas_equalTo(16);
    }];
//    UILabel * sclabel = [[UILabel alloc] init];
//    self.sclabel = sclabel;
//    sclabel.font = [UIFont systemFontOfSize:11];
//    sclabel.text = @"市场价:";
//    sclabel.textColor = ComonCharColor;
//    [self.contentView addSubview:sclabel];
//    [sclabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(photoImage.mas_right).offset(12);
//        make.top.equalTo(informationLabel.mas_bottom).offset(10);
//        make.height.mas_equalTo(11);
//    }];
    
    StrikeThroughLabel * priceLabel = [[StrikeThroughLabel alloc] init];
    self.priceLabel = priceLabel;
    priceLabel.strikeThroughEnabled = YES;
    priceLabel.font = [UIFont systemFontOfSize:11];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.textColor = ComonCharColor;
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(12);
        make.top.equalTo(informationLabel.mas_bottom).offset(10);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    
    UILabel * stockLabel = [[UILabel alloc] init];
    self.stockLabel = stockLabel;
    stockLabel.textAlignment = NSTextAlignmentLeft;
    stockLabel.font = [UIFont systemFontOfSize:11];
    stockLabel.textColor = ComonCharColor;
    [self.contentView addSubview:stockLabel];
    [stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).offset(12);
        make.top.equalTo(priceLabel.mas_bottom).offset(3);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    
    UIView * calculateView = [[UIView alloc] init];
    self.calculateView = calculateView;
    calculateView.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
    calculateView.layer.borderWidth = 0.5;
    calculateView.layer.cornerRadius = 2;
    [self.contentView addSubview:calculateView];
    [calculateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(87);
        make.right.equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(100);
    }];
    for (int i = 0; i < 2; i++) {
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = CommonBlackColor;
        [calculateView addSubview:lineView];
        if (i==0) {
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(calculateView).offset(30);
                make.width.mas_equalTo(0.5);
                make.top.equalTo(calculateView);
                make.height.mas_equalTo(25);
            }];
        }else {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(calculateView).offset(-30.5);
                make.width.mas_equalTo(0.5);
                make.top.equalTo(calculateView);
                make.height.mas_equalTo(25);
            }];
            
        }
    }
    if (SCREEN_WIDTH<=320) {
        [priceLabel setFont:[UIFont systemFontOfSize:10]];
        [calculateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
        }];
        [priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photoImage.mas_right).offset(8);
        }];
        [stockLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photoImage.mas_right).offset(8);
            make.width.mas_lessThanOrEqualTo(65);
        }];
        
        [informationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photoImage.mas_right).offset(8);
        }];
        
        [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photoImage.mas_right).offset(8);
        }];
    }
    
    UITextField * numberTextField = [[UITextField alloc] init];
    self.numberTextField = numberTextField;
    [self.numberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self creatSureButtonOnTextView];
    numberTextField.delegate =self;
    self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    numberTextField.textAlignment = NSTextAlignmentCenter;
    numberTextField.text = @"1";
    numberTextField.textColor = ComonTextColor;
    numberTextField.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    [calculateView addSubview:numberTextField];
    [numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(calculateView).offset(30.5);
        make.right.equalTo(calculateView).offset(-30.5);
        make.top.and.bottom.equalTo(calculateView);
    }];
    
    ComButton * addShopBtn = [[ComButton alloc] init];
    self.addShopBtn = addShopBtn;
    [self.contentView addSubview:addShopBtn];
    [addShopBtn addTarget:self action:@selector(addShopBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [addShopBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addShopBtn);
        make.centerY.equalTo(calculateView);
    }];
    [addShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(calculateView);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(calculateView);
        make.height.mas_equalTo(50);
    }];
    [addShopBtn.photoImage setImage:[UIImage imageNamed:@"add2"]];
//    [addShopBtn setImage:[UIImage imageNamed:@"add1"] forState:UIControlStateHighlighted];
    
    
    ComButton * subtractBtn = [[ComButton alloc] init];
    self.subtractBtn = subtractBtn;
    [subtractBtn addTarget:self action:@selector(subtractBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:subtractBtn];
    [subtractBtn.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subtractBtn);
        make.centerY.equalTo(calculateView);

    }];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(calculateView);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(calculateView);
        make.height.mas_equalTo(50);
    }];
    [subtractBtn.photoImage setImage:[UIImage imageNamed:@"subtract2"]];
//    [subtractBtn setImage:[UIImage imageNamed:@"subtract1"] forState:UIControlStateHighlighted];
    
    ComButton * selectAllBtn = [[ComButton alloc] init];
    self.selectAllBtn = selectAllBtn;
    [selectAllBtn addTarget:self action:@selector(selectAllBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.selectAllBtn.photoImage.image = [UIImage imageNamed:@"unselected"];
    [self.contentView addSubview:selectAllBtn];
    [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.and.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(44);
    }];
    [selectAllBtn.photoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    UIImageView * shopStatesImage = [[UIImageView alloc] init];
    self.shopStatesImage = shopStatesImage;
    [self.contentView addSubview:shopStatesImage];
    [shopStatesImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-12);
    }];
    
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.hidden = YES;
    self.numberLabel = numberLabel;
    numberLabel.textColor = ComonCharColor;
    numberLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-12);
    }];
    
    UILabel * stockHaveLabel = [[UILabel alloc] init];
    self.stockHaveLabel = stockHaveLabel;
    stockHaveLabel.hidden = YES;
    stockHaveLabel.text = @"库存不足";
    stockHaveLabel.textColor = ComonBackColor;
    stockHaveLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:stockHaveLabel];
    [stockHaveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(calculateView.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(calculateView);
    }];
    
}
-(void)addShopBtnAction {
//    int number = [self.shopModel.proNum intValue];
//    number++;
//    self.shopModel.proNum = [NSString stringWithFormat:@"%d",number];
    
    if ([self.shopModel.proNum intValue]<[self.shopModel.stock intValue]) {
    
    if ([self.delegate respondsToSelector:@selector(changeProduceShopCart:addBool:)]) {
        [self.delegate changeProduceShopCart:self.shopModel addBool:YES];
    }
  }
}
-(void)subtractBtnAction {
    if ([self.shopModel.proNum intValue]>1) {
//        int number = [self.shopModel.proNum intValue];
//        number--;
//        self.shopModel.proNum = [NSString stringWithFormat:@"%d",number];
        if ([self.delegate respondsToSelector:@selector(changeProduceShopCart:addBool:)]) {
            [self.delegate changeProduceShopCart:self.shopModel addBool:NO];
        }
    }
}

-(void)selectAllBtnAction {
    self.shopModel.selectedBool = !self.selectAllBtn.selected;
    if ([self.delegate respondsToSelector:@selector(selectProcut:)]) {
        [self.delegate selectProcut:self.shopModel];
    }
    
}
-(void)setModel:(HXShopCarModel *)model {
    self.shopModel  = model;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.markPrice.length!=0?model.markPrice:@""];
    self.selectAllBtn.photoImage.image = [UIImage imageNamed:model.selectedBool?@"select":@"unselected"];
    self.selectAllBtn.selected = self.shopModel.selectedBool;
    self.numberTextField.text = [NSString stringWithFormat:@"%@",model.proNum];
    if ([model.proNum intValue]<=1) {
        [_subtractBtn.photoImage setImage:[UIImage imageNamed:@"subtract1"]];
    }else {
        [_subtractBtn.photoImage setImage:[UIImage imageNamed:@"subtract2"]];
    }
    if ([model.proNum intValue]>=[model.stock intValue]) {
        
        [self.addShopBtn.photoImage setImage:[UIImage imageNamed:@"add1"]];
    }else {
        
       [self.addShopBtn.photoImage setImage:[UIImage imageNamed:@"add2"]];
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.proName.length!=0?model.proName:@"",model.specOne.length!=0?[NSString stringWithFormat:@" %@",model.specOne]:@"",model.specTwo.length!=0?[NSString stringWithFormat:@" %@",model.specTwo]:@"",model.specThree.length!=0?[NSString stringWithFormat:@" %@",model.specThree]:@""];
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:model.imgUrl width:200 height:200]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    
    model.score = model.score.length!=0?model.score:@"0";
    model.price = model.price.length!=0?[NumAgent roundDown:model.price ifKeep:YES]:@"0.00";
    self.informationLabel.text = [NSString stringWithFormat:@"%d趣贝+%@元",[model.score intValue],model.price];
    self.stockLabel.text = [NSString stringWithFormat:@"库存:%@",model.stock];
    if ([model.proOnshelfStatus isEqualToString:@"1"] && model.proOnshelfStatus.length!=0) {
        self.selectAllBtn.hidden = NO;
        [self.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(44);
        }];
        self.contentView.backgroundColor = CommonBackViewColor;
        self.titleLabel.textColor = ComonTextColor;
        if ([model.proNum intValue]>[model.stock intValue]) {
            self.stockHaveLabel.hidden = NO;
        }else {
            self.stockHaveLabel.hidden = YES;
        }
        NSInteger fontNumber = SCREEN_WIDTH<=320?12:16;
        _informationLabel.textColor = kUIColorFromRGB(0x252525);
        [Helper changeTextWithFont:fontNumber title:self.informationLabel.text changeTextArr:@[[NSString stringWithFormat:@"%d",[model.score intValue]],model.price] label:self.informationLabel color:ComonBackColor];
        self.calculateView.hidden = NO;
        self.addShopBtn.hidden = NO;
        self.subtractBtn.hidden = NO;
        self.shopStatesImage.hidden = YES;
        if (SCREEN_WIDTH<=320) {
            [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_lessThanOrEqualTo(28);
                make.left.equalTo(self.photoImage.mas_right).offset(8);
            }];
            [self.stockLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.photoImage.mas_right).offset(8);
                make.width.mas_lessThanOrEqualTo(62);
            }];
        }
    }else {
        self.stockHaveLabel.hidden = YES;
        self.selectAllBtn.hidden = YES;
        [self.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
        }];
        self.backgroundColor = kUIColorFromRGB(0xF9F9F9);
        self.titleLabel.textColor = ComonCharColor;
        NSInteger fontNumber = SCREEN_WIDTH<=320?12:16;
        self.informationLabel.textColor = ComonCharColor;
        [Helper changeTextWithFont:fontNumber title:self.informationLabel.text changeTextArr:@[[NSString stringWithFormat:@"%d",[model.score intValue]],model.price] label:self.informationLabel color:ComonCharColor];
        self.calculateView.hidden = YES;
        self.addShopBtn.hidden = YES;
        self.subtractBtn.hidden = YES;
        self.shopStatesImage.hidden = NO;
        self.shopStatesImage.image = [UIImage imageNamed:[model.proOnshelfStatus isEqualToString:@"2"]?@"shopXiajia":@"shopQiangwan"];
    }
    
}
-(void)setDetailBool:(BOOL)detailBool {
    if (detailBool) {
        [self.selectAllBtn removeFromSuperview];
        [self.addShopBtn removeFromSuperview];
        [self.subtractBtn removeFromSuperview];
        [self.stockLabel removeFromSuperview];
        [self.shopStatesImage removeFromSuperview];
        self.numberLabel.hidden = NO;
        [self.photoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
        }];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(120);
        }];
        
        [self.calculateView removeFromSuperview];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(changeTextField:)]) {
        
        [self.delegate changeTextField:textField];
    }
    
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text intValue]==0 && textField.text.length!=0) {
       
    }
    if ([textField.text intValue]>=[self.shopModel.stock intValue]) {
        textField.text = self.shopModel.stock;
    }
    if ([self.numberTextField.text intValue]>[self.shopModel.stock intValue]) {
        self.stockHaveLabel.hidden = NO;
    }else {
        self.stockHaveLabel.hidden = YES;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.shopModel.proNum intValue]>[self.shopModel.stock intValue]) {
        self.stockHaveLabel.hidden = NO;
    }else {
        self.stockHaveLabel.hidden = YES;
    }
    textField.text = self.shopModel.proNum;
    [self reloadInputViews];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
    
    
}
-(void)setProModel:(HXProArrModel *)proModel {

    self.stockHaveLabel.hidden = YES;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",proModel.skuMarketprice.length!=0?proModel.skuMarketprice:@""];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",proModel.proName.length!=0?proModel.proName:@"",proModel.specOne.length!=0?[NSString stringWithFormat:@" %@",proModel.specOne]:@"",proModel.specTwo.length!=0?[NSString stringWithFormat:@" %@",proModel.specTwo]:@"",proModel.specThree.length!=0?[NSString stringWithFormat:@" %@",proModel.specThree]:@""];

    proModel.skuScore = proModel.skuScore.length!=0?[NSString stringWithFormat:@"%d",[proModel.skuScore intValue]]:@"0";
    proModel.skuPrice = proModel.skuPrice.length!=0?[NumAgent roundDown:proModel.skuPrice ifKeep:YES]:@"0.00";

    self.informationLabel.text = [NSString stringWithFormat:@"%@趣贝+¥%@",proModel.skuScore,proModel.skuPrice];
    [Helper changeTextWithFont:16 title:self.informationLabel.text changeTextArr:@[proModel.skuScore,proModel.skuPrice] label:self.informationLabel color:ComonBackColor];

    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[Helper photoUrl:proModel.imgUrl width:200 height:200]] placeholderImage:[UIImage imageNamed:@"listLogo"]];
    self.numberLabel.text = proModel.quantity.length!=0?[NSString stringWithFormat:@"X%@",proModel.quantity]:@"";
}
#pragma mark-键盘确定按钮
-(void)creatSureButtonOnTextView{
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 50, 44)];
    doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [doneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,5)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitleColor:ComonBackColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    [nextButton setTintColor:ComonCharColor];
    [nextButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolBar.items = @[nextButton,spaceItem,item];
    [self.numberTextField setInputAccessoryView:toolBar];
}
-(void)dismissKeyBoard {
    if ([self.delegate respondsToSelector:@selector(updateNewNumber: model: index:)]) {
        
        [self.delegate updateNewNumber:self.numberTextField model:self.shopModel index:self.indexPath];
    }
}
-(void)nextTextField {
    
    [self.numberTextField resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
