//
//  KKCodeValidationModel.m
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import "KKCodeValidationModel.h"
#import "NetWorkError.h"
@implementation KKCodeValidationModel
-(void)requestCodeVAlidation:(getCodeValidation)codeBlock{
    serviceucReCaptchaApigetCaptchaEmptyRequest *req = [serviceucReCaptchaApigetCaptchaEmptyRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(serviceucCaptchaResponse *  _Nonnull message) {
        if (codeBlock) {
            codeBlock(message.captchaId,message.imageSrc);
        }
    } failed:^(requestErrorCode errorCode) {
        NSString* errorCodeStr = [[NetWorkError getInstance]getCode:(int)errorCode];
        [SVProgressHUD showMessage:errorCodeStr];
    }];
}

-(void)requestSendCodeID:(NSInteger )codeId withCodeText:(NSString *)codeStr WithValidationBlock:(getSendValidation)sendBlock{
    
    serviceucReCaptchaApivalidCaptchaCaptchaValid *req = [serviceucReCaptchaApivalidCaptchaCaptchaValid createRequest];
    req.request.captchaId = codeId;
    req.request.code = codeStr;
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(serviceucReCaptchaValidResponse *  _Nonnull message) {
        if (sendBlock) {
            sendBlock(YES,message.reCaptchaId);
        }
    } failed:^(requestErrorCode errorCode) {
        if (sendBlock) {
            sendBlock(NO,errorCode);
        }
//        NSString* errorCodeStr = [[NetWorkError getInstance]getCode:(int)errorCode];
//        [SVProgressHUD showMessage:errorCodeStr];
    }];
    
    
    
}
@end
