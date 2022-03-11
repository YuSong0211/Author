#include "serviceucReSmsApisendValidWithCaptchaSmsSendRequest.h"
@implementation serviceucReSmsApisendValidWithCaptchaSmsSendRequest

+( serviceucReSmsApisendValidWithCaptchaSmsSendRequest *)createRequest
{
    serviceucReSmsApisendValidWithCaptchaSmsSendRequest* request = [[ serviceucReSmsApisendValidWithCaptchaSmsSendRequest alloc] init];
    request.apiName = @"uc.ReSmsApi/sendValidWithCaptcha";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucSmsSendRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucSmsSendResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end