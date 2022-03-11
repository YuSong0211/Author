//
//  PhoneLoginView.h
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "KKLoginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhoneLoginView : UIView
// 是否为绑定手机号
@property (nonatomic,assign) BOOL isBingDingPhone;
// 是否修改手机号
@property (nonatomic,assign) BOOL isUpdataPhone;
// 是否确认修改手机号
@property (nonatomic,assign) BOOL isCommintUpdataPhone;
// 是否登录
@property (nonatomic,assign) BOOL isSign;
// 是否切换账号
@property (nonatomic,assign) BOOL isSwitchACcount;
// 手机号快捷登录
@property (nonatomic,strong) UILabel * phoneDesc;

// 绑定手机号提醒标题
@property (nonatomic,strong) UILabel * bingDingTipL;

// 选择手机区号
@property (nonatomic,strong) CoustomButton * selectAreaCodeButton;

// 选择区号右边线条
@property (nonatomic,strong) UIView * selectAreaCodeRightLineView;

// 手机号输入框
@property (nonatomic,strong) UITextField * phoneTextFiled;

// 手机号底部输入框
@property (nonatomic,strong) UIView * phoneBottomLineView;

// 短信验证码
@property (nonatomic,strong) UITextField * phoneCode;

// 验证码底部线条
@property (nonatomic,strong) UIView * phoneCodeBottomLineView;

// 获取验证码
@property (nonatomic,strong) UIButton * getPhoneCodeButton;

// 绑定手机号底部提醒标题
@property (nonatomic,strong) UILabel * bingDingBottomTipL;

// 绑定手机号底部提醒图标
@property (nonatomic,strong) UIImageView * bingDingBottomTipIcon;
// 登录按钮
@property (nonatomic,strong) UIButton * loginButton;


//监听属性变化,
@property (nonatomic,assign)UIColor *getPhoneCodeColor;
//获取验证码按钮文字监听
@property (nonatomic,strong)NSString* codeTitle;

// 代理
@property (nonatomic,weak) id<KKLoginDelegate>delegate;

// 改变获取验证码按钮颜色设置
-(void)changeLoginButtonStyle:(BOOL)isEnable;
// 倒计时
- (void)verifyEvent;
// 取消并重置倒计时
- (void)cancelPreviousPerformRequestsWithTarget;


-(void)addListener;
@end

NS_ASSUME_NONNULL_END
