//
//  ContactInfoTableViewCell.h
//  ConsumerFinance
//
//  Created by 侯荡荡 on 16/7/18.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfoTableViewCell;
@protocol ContactInfoTableViewCellDelegate <NSObject>

- (void)changePhoneNumberByCell:(ContactInfoTableViewCell*)cell withType:(NSString *)type;
- (void)changeRelationByCell:(ContactInfoTableViewCell*)cell withType:(NSString *)type;

@end
typedef void (^clickEventBlock)(NSInteger clickTag);

@interface ContactInfoTableViewCell : UITableViewCell

@property (nonatomic, weak)   id<ContactInfoTableViewCellDelegate> delegate;
@property (nonatomic, strong) UILabel  *uiContact;
@property (nonatomic, strong) UIButton *uiPhone;
@property (nonatomic, strong) UIButton *uiName;
@property (nonatomic, strong) UIButton *uiAdd;
@property (nonatomic, strong) UIView   *uiLine;

@property (nonatomic, strong) UIButton *uiPhoneButton;

@property (nonatomic, strong) NSString          *relation;

@property (nonatomic, strong) NSString          *type;//对应关系
@property (nonatomic, copy  ) clickEventBlock   block;


@end
