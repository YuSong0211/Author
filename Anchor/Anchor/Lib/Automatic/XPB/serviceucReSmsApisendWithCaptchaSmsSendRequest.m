#include "serviceucReSmsApisendWithCaptchaSmsSendRequest.h"
@implementation serviceucReSmsApisendWithCaptchaSmsSendRequest

+( serviceucReSmsApisendWithCaptchaSmsSendRequest *)createRequest
{
    serviceucReSmsApisendWithCaptchaSmsSendRequest* request = [[ serviceucReSmsApisendWithCaptchaSmsSendRequest alloc] init];
    request.apiName = @"uc.ReSmsApi/sendWithCaptcha";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucSmsSendRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucSmsSendResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end