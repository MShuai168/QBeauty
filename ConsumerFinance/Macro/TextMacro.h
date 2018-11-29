//
//  TextMacro.h
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/5.
//  Copyright © 2016年 Hou. All rights reserved.
//

#ifndef TextMacro_h
#define TextMacro_h

#define DefineText_NetRestore                         @"网络连接已恢复"
#define DefineText_NotNet                             @"当前网络不可用，请检查网络连接！"
#define DefineText_Hotline                            @"02131125952" //@"4000466600"

#pragma mark - 友盟点击事件（UMEvents）

#define Event_login_in                          @"login_in"
#define Event_login_out                         @"login_out"
#define Event_forgot_password                   @"forgot_password"
#define Event_get_verification_code             @"get_verification_code"
#define Event_register                          @"register"
#define Event_order_detail                      @"order_detail"
#define Event_application_stage                 @"application_stage"
#define Event_cancel_application                @"cancel_application"
#define Event_supply_image                      @"supply_image"
#define Event_get_image_info                    @"get_image_info"
#define Event_upload_image                      @"upload_image"
#define Event_update_image                      @"update_image"
#define Event_check_identity_info               @"check_identity_info"
#define Event_identity_authentication           @"identity_authentication"
#define Event_check_family_info                 @"check_family_info"
#define Event_submit_family_info                @"submit_family_info"
#define Event_check_bankcard_info               @"check_bankcard_info"
#define Event_bind_bankcard                     @"bind_bankcard"
#define Event_change_bankcard                   @"change_bankcard"
#define Event_bindcard_message                  @"bindcard_message"
#define Event_signed_withholding                @"signed_withholding"
#define Event_check_contact_info                @"check_contact_info"
#define Event_submit_contact_info               @"submit_contact_info"
#define Event_check_internet_info               @"check_internet_info"
#define Event_submit_internet_info              @"submit_internet_info"
#define Event_check_school_info                 @"check_school_info"
#define Event_submit_school_info                @"submit_school_info"
#define Event_change_identity                   @"change_identity"
#define Event_check_my_bankcard                 @"check_my_bankcard"
#define Event_check_company_info                @"check_company_info"
#define Event_modify_password                   @"modify_password"
#define Event_call_hotline                      @"call_hotline"
#define Event_submit_auth_info                  @"submit_auth_info"
#define Event_submit_jd_info                    @"submit_jd_info"
#define Event_jump_jd_info                      @"jump_jd_info"
#define Event_register_protocol                 @"register_protocol"
#define Event_secret_protocol                   @"secret_protocol"
#define Event_loan_contract                     @"loan_contract"
#define Event_loan_consult_service_protocol     @"loan_consult_service_protocol"


#define Event_ocr_idcard_success              @"ocr_idcard_success"
#define Event_ocr_bankcard_success            @"ocr_bankcard_success"
#define Event_name_authentication_success     @"name_authentication_success"

/*
 login_in,登录,0
 login_out,退出登录,0
 register_protocol,壹分期注册协议,0
 secret_protocol,壹分期隐私协议,0
 forgot_password,忘记密码,0
 get_verification_code,获取手机验证码,0
 register,注册,0
 order_detail,订单详情,0
 application_stage,申请分期,0
 cancel_application,取消申请,0
 supply_image,补充影像,0
 get_image_info,获取影像附件信息,0
 upload_image,上传影像附件,0
 update_image,更新影像附件,0
 loan_contract,借款合同,0
 loan_consult_service_protocol,借款咨询服务协议,0
 change_identity,切换身份,0
 modify_password,修改密码,0
 call_hotline,拨打客服热线,0
 submit_auth_info,提交认证信息,0
 submit_jd_info,提交京东认证信息,0
 jump_jd_info,跳过京东认证信息,0
 check_my_bankcard,查看我的银行卡,0
 check_company_info,查看公司信息,0
 signed_withholding,签署代扣,0
 check_identity_info,查看身份认证信息,0
 identity_authentication,身份认证,0
 check_family_info,查看家庭信息,0
 submit_family_info,提交家庭信息,0
 check_bankcard_info,查看银行卡信息,0
 bind_bankcard,绑定银行卡,0
 change_bankcard,更换银行卡,0
 bindcard_message,获取绑定银行卡短信,0
 check_contact_info,查看联系人信息,0
 submit_contact_info,提交联系人信息,0
 check_internet_info,查看互联网信息,0
 submit_internet_info,提交互联网信息,0
 check_school_info,查看学校信息,0
 submit_school_info,提交学校信息,0

 */

/**
 *  身份状态
 */

#define MyStatuesTypeBusiness                   @"01"
#define MyStatuesTypeWorker                     @"02"
#define MyStatuesTypeStudent                    @"03"
#define MyStatuesTypeFreelance                  @"04"



#pragma mark - 其他（other）
/** 限制输入，只能为数字 */
#define LIMIT_NUMBERS               @"0123456789\n"
/** 限制输入，只能为字母、数字 */
#define LIMIT_ALPHANUM              @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n"

#define access_key                  @"C046B2DC9820418F9EE1DB8C080F83F1"

/** 分享相关 */
#define UMAppkey                    @"598d0a2aaed17973520018d4"
/*
#define WXAppId                     @"wxe94d5c394546dab1"
#define WXAppSecret                 @"688ad3ac34d441caf0ce7749cd63ad97"

#define QQAppkey                    @"PgaTSFFrEOzxRJcV"
#define QQAppId                     @"1105234553"

#define SinaAppkey                  @"3266429860"
#define SinaAppSecret               @"597514addf8010cbd3271c67c7064f46"
*/
#endif /* TextMacro_h */
