//
//  HXUploadCertificateTableViewCell.m
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import "HXUploadCertificateTableViewCell.h"

@interface HXUploadCertificateTableViewCell()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *decLabel;
@property (nonatomic, strong) UIView *verifyView;
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UIView *verticalView;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation HXUploadCertificateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        _array = [[NSMutableArray alloc] initWithObjects:@"big1",@"big1",@"big1",@"big1",@"big1",@"big1",@"big1", nil];
        [self setUpView];
    }
    return self;
}

- (UIView *)verticalView {
    if (!_verticalView) {
        _verticalView = [[UIView alloc] init];
        _verticalView.backgroundColor = ColorWithHex(0x4A90E2);
    }
    return _verticalView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWithHex(0xE6E6E6);
    }
    return _lineView;
}

- (UILabel *)decLabel {
    if (!_decLabel) {
        _decLabel = [[UILabel alloc] init];
        _decLabel.numberOfLines = 0;
        _decLabel.textColor = ColorWithHex(0x999999);
        _decLabel.font = [UIFont systemFontOfSize:13];
        NSString *dec = @"为保障您的权益，我们在放款前，需要商户上传首付凭证/发票，汽车合格证，交强险和商业保险单等影像凭证，经我司审批凭证有效，即放款！";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:dec];
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, dec.length)];
        _decLabel.attributedText = attr;
    }
    return _decLabel;
}

- (UILabel *)successLabel {
    if (!_successLabel) {
        _successLabel = [[UILabel alloc] init];
        _successLabel.text = @"您的订单已审核通过。";
        _successLabel.textColor = ColorWithHex(0x999999);
        _successLabel.font = [UIFont systemFontOfSize:13];
    }
    return _successLabel;
}

- (UIView *)verifyView {
    if (!_verifyView) {
        _verifyView = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = ColorWithHex(0x999999);
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"凭证已上传，正在审核中...";
        
        [_verifyView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_verifyView).offset(0);
            make.top.equalTo(_verifyView).offset(0);
            make.right.equalTo(_verifyView).offset(-15);
            make.bottom.equalTo(_verifyView).offset(0);
        }];
        
//        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.pagingEnabled = YES;
//        scrollView.contentSize = CGSizeMake(self.array.count *90, 75);
//        [self.array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
//            imageView.frame = CGRectMake((0+idx)*90, 0, 75, 75);
//            [scrollView addSubview:imageView];
//        }];
//        
//        [_verifyView addSubview:scrollView];
//        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(_verifyView).offset(0);
//            make.top.equalTo(label.mas_bottom).offset(10);
//            make.bottom.equalTo(_verifyView).offset(0);
//        }];
        
    }
    return _verifyView;
}

- (void)setUpView {
    self.imageView.image = [UIImage imageNamed:@"payWait"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo([UIImage imageNamed:@"payWait"].size);
    }];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(18);
        
    }];
    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
    self.detailTextLabel.textColor = ColorWithHex(0x999999);
    
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.imageView.mas_top);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(35);
        make.top.equalTo(self.contentView).offset(45);
        make.right.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.contentView addSubview:self.decLabel];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(35);
        make.bottom.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.contentView addSubview:self.successLabel];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(35);
        make.bottom.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.verifyView];
    [self.verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(35);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.contentView addSubview:self.verticalView];
    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(21);
        make.bottom.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.imageView.mas_bottom);
        make.width.mas_equalTo(0.5);
    }];
}

- (void)setUploadCertificateStatus:(uploadCertificateStatus)uploadCertificateStatus {
    _uploadCertificateStatus = uploadCertificateStatus;
    switch (uploadCertificateStatus) {
        case uploadCertificateStatusBefore:
            self.decLabel.hidden = NO;
            self.successLabel.hidden = YES;
            self.verifyView.hidden = YES;
            break;
        case uploadCertificateStatusSucess:
            self.decLabel.hidden = YES;
            self.successLabel.hidden = NO;
            self.verifyView.hidden = YES;
            self.textLabel.textColor = ColorWithHex(0x4990E2);
            self.imageView.image = [UIImage imageNamed:@"orderSuccess"];
            break;
        case uploadCertificateStatusverifying:
            self.decLabel.hidden = YES;
            self.successLabel.hidden = YES;
            self.verifyView.hidden = NO;
            self.imageView.image = [UIImage imageNamed:@"wait2"];
            break;
            
        default:
            break;
    }
}

- (void)setHiddenVerticalLine:(BOOL)hiddenVerticalLine {
    _hiddenVerticalLine = hiddenVerticalLine;
    self.verticalView.hidden = hiddenVerticalLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
