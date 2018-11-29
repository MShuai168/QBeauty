//
//  Helper.h
//  huaxiafinance_user
//
//  Created by huaxiafinance on 16/2/18.
//  Copyright © 2016年 huaxiafinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HXSuportBankModel.h"
typedef  void (^ReturnValueBlock) ();
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();

@interface Helper : NSObject
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;

//邮箱
+ (BOOL) justEmail:(NSString *)email;

//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;

//车型
+ (BOOL) justCarType:(NSString *)CarType;

//用户名
+ (BOOL) justUserName:(NSString *)name;

//密码
+ (BOOL) justPassword:(NSString *)passWord;

//昵称
+ (BOOL) justNickname:(NSString *)nickname;

//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard;

//在数字中间添加逗号
+ (NSString *)localizedStringFromNumber:(NSInteger)num;

//判断是否是纯数字
+ (BOOL)isPureInt:(NSString *)string;

//判断是否为纯字母
+(BOOL)isPureCharCharacters:(NSString *)string;

//hmac_sha256加密
+ (NSString *)hmac_sha256:(NSString *)text;

//字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//byte数组转NSData
+ (NSData *)ByteArrayToData:(NSArray *)byteArray;

/**
 *  含有特殊字符
 */
+(BOOL)hasSpecialChar:(NSString*)str;

/**
 只有数字和字母

 @param str
 @return
 */
+(BOOL)hasOnlyNumAndChar:(NSString*)str;

/**
 *  添加逗号
 */
+(NSString*)addComma:(NSString*)string;

/**
 *  求字符串里面所有数字的和
 */

+ (NSString *)sumWithString:(NSString *)string;

/**
 *  字符串转为纯数字
 */
+ (NSString *)replaceString:(NSString *) string;


+ (BOOL)isChinese:(NSString *) string;

/**
 *  判断是否有表情字符
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
/**
 *  将RGB颜色值转换为图片
 */
+ (void)createImageWithColor:(UIColor *)color button:(UIButton *)button style:(UIControlState)state;

/**
 调节文字大小
 @param label
 @param str
 @param font
 */
+(void)adjustLabel:(UILabel *)label str:(NSString *)str font:(NSInteger)font;
+(void)justLabel:(UILabel *)label title:(NSString *)title font:(NSInteger)font;
+(void)justColorLabel:(UILabel *)label firTitle:(NSString *)title secTitle:(NSString *)secTitle font:(NSInteger)font;

/**
 更改图片URL

 @param url url
 @param width 宽度
 @param height 高度
 @return 更改完的url
 */
+(NSString *)photoUrl:(NSString *)url width:(NSInteger)width height:(NSInteger)height;



/**
 判断银行卡是否属于支持银行

 @param card 银行卡号
 @return YES NO
 */
+(HXSuportBankModel *)belogCardNumber:(NSString *)card bankArr:(NSMutableArray *)bankArr;


/**
 根据银行卡号匹配名称

 @param idCard 银行卡号
 @return 名称
 */
+(NSString *)returnBankName:(NSString*) idCard;

/**
 调整银行卡名称

 @param bankName 银行卡名称
 @return 匹配后的银行卡名称
 */

+(NSString *)exchangeBankeName:(NSString *)bankName;

/**
 校验固定电话

 @param cellNum 电话号码
 @return 回调
 */
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum;

/**
 检测实名认证
 */
+(BOOL)authBool:(NSString *)auth;

/**
 调整文字颜色 大小

 @param font 大小
 @param title 全部文本
 @param changeText 修改的文本数组
 @param label label
 */
+(void)changeTextWithFont:(NSInteger )font title:(NSString *)title changeTextArr:(NSArray *)changeTextArr label:(UILabel *)label color:(UIColor *)color;
/**
 判断数字输入的位数
 
 @param textField textfield
 @param range 范围
 @param string 文本
 @return 返回
 */
+(BOOL)justNumerWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string numberLength:(NSInteger)length;

+(void)textField:(UITextField *)textField length:(NSInteger)length;

+(void)textFieldDidChange:(UITextField *)textField length:(NSInteger)length;

+(NSString *)reviseString:(id)str;

+(void)pushLogin:(UIViewController *)controller;


/*
  2018-05-30 16:04:42
 */
+ (NSString *)dateWithTimeStampAll:(NSInteger)time; //时间戳转成"yyyy-MM-dd HH:mm:ss"格式
+ (NSString *)dateWithTimeStampDate:(NSInteger)time; //时间戳转成"yyyy-MM-dd"格式
+ (NSString *)getTimeStrWithString:(NSString *)str;  //将时间转成时间戳
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space; //label多行显示时，行间距


@end
