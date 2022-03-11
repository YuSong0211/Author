//
//  KKLoginDelegate.h
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KKLoginDelegate <NSObject>

/// 点击按钮，获取手机验证码·
/// @param phoneCode 用户手机号
-(void)clickGetPhoneAuthenticationCode:(NSString *)phoneCode;


/// 点击登录按钮
/// @param userPhone 用户手机号
/// @param userPhoneCode 用户验证码 或 用户密码
-(void)clickLoginButton:(NSString *)userPhone userPhoneCode:(NSString *)userPhoneCode;


@end

NS_ASSUME_NONNULL_END
