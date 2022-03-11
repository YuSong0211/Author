//
//  LoginViewModel.m
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import "LoginViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SmsModel.h"
#import "UcPrimaryApiSign.pbobjc.h"// 用户层登录请求类
//#import "UcBind.pbobjc.h"// 用户层登录获取用信息类
#import "UcAccount.pbobjc.h"// 用户层登录获取用信息类
#import "UcPrimaryApiBind.pbobjc.h"// 用户层用户绑定手机号
#import "UcSms.pbobjc.h"// 用户层获取手机号验证码类
#import "UcPrimaryApiRecaptcha.pbobjc.h"// 用户层用户获取阿里云图片验证码
#import "UcPrimaryApiResms.pbobjc.h"// 获取验证码
//#import "ucBindTelephoneApichangeBindChange.h"
#import "serviceucBindTelephoneApichangeBindChange.h"

#import "SignController.h"
#import "NetWorkError.h"
@interface LoginViewModel()
@property (nonatomic,strong) SmsModel* smsModel;
@property (nonatomic,strong)SignController* signController;
@property (nonatomic,assign) NSInteger smID;// 验证码ID
@property (nonatomic,assign) NSInteger reCaptchaId;// 阿里云验证ID
@property (nonatomic,strong) NSString* phoneNum;// 手机号
@property (nonatomic,strong) NSString* smsCode;// 验证码
@end

@implementation LoginViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self initListener];
    }
    return self;
}

+ (LoginViewModel *)initWithType:(LoginType)loginType{
    LoginViewModel* lm = [[LoginViewModel alloc] init];
    lm.loginType = loginType;
    return lm;
}

//请求登陆功能
- (void)login{
    
}

//初始化数据,初始化model等。
- (void)initData{
    self.smsModel = [[SmsModel alloc] init];
    self.signController = [[SignController alloc] init];
    [self.signController.loginSignilCallBack subscribeNext:^(id  _Nullable x) {
        [self.bindSuccess sendNext:@""];
    }];
}

//监听数据,手机号码变动，去请求验证码信息
- (void)initListener{
     
}

//请求获取(阿里云)验证码
-(void)getCode: (NSString *)phoneNUm :(BOOL)isSign{
    self.phoneNum = phoneNUm;
    if(self.loginType == BindPhone || self.loginType == ChangePhone){
        [self.smsModel reqGetBindSmsCode:phoneNUm :^(id  _Nonnull message) {
            [self.getCodeSuccess sendNext:message];
        } :nil];
    }
    else{
        [self.smsModel reqGetChangeAccontCode:phoneNUm :^(id  _Nonnull message) {
            [self.getCodeSuccess sendNext:message];
        } :nil];
    }
}


//点击提交按钮
-(void)onBtnLoginOk:(NSString*)code{
    if(self.loginType == BindPhone || self.loginType == ChangePhone){
        [self bindPhone:code];
    }
    else{
        [self changePhone:code];
    }
}


//开始绑定手机号
-(void)bindPhone:(NSString*)code{
    
    serviceucBindTelephoneApichangeBindChange* req = [serviceucBindTelephoneApichangeBindChange createRequest];
    req.request.tel = [[serviceucTelephone alloc] init];
    req.request.sms = [[serviceucSmsValid alloc] init];
    req.request.tel.region =@"+86";
    req.request.tel.telephone = self.phoneNum;
    req.request.sms.smsId = self.smsModel.smsId;
    req.request.sms.smsCode = code;
    
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(id  _Nonnull message) {
        [self.bindSuccess sendNext:self.phoneNum];
    } failed:^(requestErrorCode errorCode) {
        if (errorCode == 8) {
            [SVProgressHUD showMessage:@"温馨提示\n该手机号被他人绑定"];
        }else if (errorCode == 5){
            [SVProgressHUD showMessage:@"温馨提示\n验证码校验失败，请重新获取"];
        }
        else{
            NSString* errorCodeStr = [[NetWorkError getInstance]getCode:(int)errorCode];
            [SVProgressHUD showMessage:errorCodeStr];
        }
        [KKLoadingView hidden];
    }];
 
}

//切换手机号,好像是用的一个接口，直接调用
-(void)updatePhone:(NSString *)code{
    [self bindPhone:code];
}
 

//登陆其他账号
- (void)changePhone:(NSString *)code{
    [self.signController telephoneLogin:self.smsModel.smsId sms_code:code region:@"+86" telephone:self.phoneNum uuid:@""];
}

//初始化事件 
-(RACSubject*)getCodeSuccess{
    if(!_getCodeSuccess){
        _getCodeSuccess = [RACSubject subject];
    }
    return _getCodeSuccess;
}

-(RACSubject*)bindSuccess{
    if(_bindSuccess == nil){
        _bindSuccess = [RACSubject subject];
    }
    return _bindSuccess;
}

@end
