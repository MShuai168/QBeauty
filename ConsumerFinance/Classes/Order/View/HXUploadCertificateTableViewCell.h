//
//  HXUploadCertificateTableViewCell.h
//  ConsumerFinance
//
//  Created by 刘勇强 on 2017/5/8.
//  Copyright © 2017年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

// 上传凭证状态
typedef NS_ENUM(NSInteger, uploadCertificateStatus) {
    uploadCertificateStatusBefore,// 上传之前
    uploadCertificateStatusverifying,// 审核中
    uploadCertificateStatusSucess// 审核通过
};

@interface HXUploadCertificateTableViewCell : UITableViewCell

@property (nonatomic, assign) uploadCertificateStatus uploadCertificateStatus;
@property (nonatomic, assign) BOOL hiddenVerticalLine;

@end
