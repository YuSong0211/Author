//
//  LoginViewModel.h
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "LoginModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN



@interface LoginViewModel : BaseViewModel
        

//绑定vm操作类型
+(LoginViewModel*)initWithType:(LoginType)loginType;

-(void)login;

/**
 ////// 监听绑定，用于处理验证码可用
 */
@property (nonatomic,strong) RACSubject *getCodeSuccess;

/**
 ////// 绑定成功
 */
@property (nonatomic,strong) RACSubject *bindSuccess;
//获取验证码
- (void)getCode:(NSString *)phoneNUm isSign:(BOOL)isSign;

/**
 ////// 操作类型
 */
@property (nonatomic,assign) LoginType loginType;

/**
 ////// 获取验证码
 @param phoneNUm 输入的验证码
 @param isSign 是否已登陆
 */
-(void)getCode: (NSString *)phoneNUm :(BOOL)isSign;

 

//点击提交按钮
-(void)onBtnLoginOk:(NSString*)code;

@end

NS_ASSUME_NONNULL_END
