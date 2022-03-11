//
//  LoginViewController.h
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import "KKSecondBaseVC.h"
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : KKSecondBaseVC
@property (nonatomic,assign) BOOL isSign;// 是否为登录
/**
 ////// 操作类型
 */
@property (nonatomic,assign) LoginType loginType;
@property (nonatomic,assign) BOOL isBingDingPhone;// 是否为绑定手机号
@property (nonatomic,assign) BOOL isSwitchACcount;// 是否切换账号
@property (nonatomic,assign) BOOL isUpdataPhone;// 是否修改手机号
@property (nonatomic,assign)NSInteger bindValidId;// 验证手机号请求失效时间是否超过

@property (nonatomic,assign) BOOL isWebviewFrom; // 是否从webview页面进入的绑定/改绑手机号页面，如果是，直接返回webview

@end

NS_ASSUME_NONNULL_END
