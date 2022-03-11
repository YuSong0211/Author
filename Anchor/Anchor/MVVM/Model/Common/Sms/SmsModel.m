//
//  SmsModel.m
//  KK
//
//  Created by hk on 2021/8/6.
//

#import "SmsModel.h"

#import "serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest.h"

#import "serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest.h"
#import "serviceucReSmsApisendValidWithCaptchaSmsSendRequest.h"
#import "serviceucReSmsApismsContentGetSmsCode.h"
#import "NetWorkError.h"
@interface SmsModel()



//成功回调
@property(nonatomic,strong) onRequestSuccess sserviceuccess;

@end


@implementation SmsModel

    
//请求获取验证码readyId
- (void)reqGetBindSmsCode:(NSString*)phoneNum
                      :(onRequestSuccess)sserviceuccess
                      :(onRequestFail)fail{
    self.sserviceuccess = sserviceuccess;
    self.phoneNum = phoneNum;
    serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest* req = [serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest createRequest];
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(serviceucReCaptchaValidResponse*  message) {
        self.reCaptchaId = message.reCaptchaId;
        [self requestGetSmsId];
    } failed:^(requestErrorCode errorCode) {
        [SVProgressHUD showMessage:@"获取验证码失败"];
    }];
    
}
//请求获取切换账户验证码
-(void)reqGetChangeAccontCode:(NSString*)phoneNum
                             :(onRequestSuccess)sserviceuccess
                             :(onRequestFail)fail{
    self.sserviceuccess = sserviceuccess;
    self.phoneNum = phoneNum;
    serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest* req = [serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest createRequest];
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(serviceucReCaptchaValidResponse*  message) {
        self.reCaptchaId = message.reCaptchaId;
        [self requestChangeAccont];
    } failed:^(requestErrorCode errorCode) {
        [SVProgressHUD showMessage:@"获取验证码失败"];
    }];
    
}

//请求切换账号
-(void)requestChangeAccont{
    serviceucReSmsApisendValidWithCaptchaSmsSendRequest* req = [serviceucReSmsApisendValidWithCaptchaSmsSendRequest createRequest];
    req.request.reCaptchaId = self.reCaptchaId;
    req.request.tel = [[serviceucTelephone alloc] init];
    req.request.tel.region = @"+86";
    req.request.tel.telephone = self.phoneNum;
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(serviceucSmsSendResponse*  _Nonnull message) {
        self.smsId = message.smsId;
        [self getSmsReq];
    } failed:^(requestErrorCode errorCode) {
        NSString* errorCodeStr = [[NetWorkError getInstance]getCode:(int)errorCode];
        [SVProgressHUD showMessage:errorCodeStr];
    }];
}


//获取临时验证码id
-(void)requestGetSmsId{
    serviceucReSmsApisendWithCaptchaSmsSendRequest* req = [serviceucReSmsApisendWithCaptchaSmsSendRequest createRequest];
    req.request.reCaptchaId = self.reCaptchaId;
    req.request.tel = [[serviceucTelephone alloc] init];
    req.request.tel.region = @"+86";
    req.request.tel.telephone = self.phoneNum;
    [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(serviceucSmsSendResponse*  _Nonnull message) {
        self.smsId = message.smsId;
        [self getSmsReq];
    } failed:^(requestErrorCode errorCode) {
        if (errorCode ==PhoneNumberHasbeenBinding) {
            [SVProgressHUD showMessage:@"手机号被他人绑定"];
        }
    }];
}

-(void)getSmsReq{
#ifdef OPEN_MODEL
    self.sserviceuccess(@"");
#else
        serviceucReSmsApismsContentGetSmsCode* req = [serviceucReSmsApismsContentGetSmsCode createRequest];
        req.request.smsId = self.smsId;
        [[NetWorkMgr ucCreateMgrWithMessage:req useToken:YES] sendRequest:^(serviceucSmsCodeResp*  _Nonnull message) {
            NSLog(@"获取验证码成功!%@",message.smsCode);
            self.sserviceuccess(message.smsCode);
    
        } failed:^(requestErrorCode errorCode) {
            [SVProgressHUD showMessage:@"获取验证码失败"];
        }];
#endif
}

@end
