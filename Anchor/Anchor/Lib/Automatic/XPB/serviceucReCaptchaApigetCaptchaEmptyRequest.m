#include "serviceucReCaptchaApigetCaptchaEmptyRequest.h"
@implementation serviceucReCaptchaApigetCaptchaEmptyRequest

+( serviceucReCaptchaApigetCaptchaEmptyRequest *)createRequest
{
    serviceucReCaptchaApigetCaptchaEmptyRequest* request = [[ serviceucReCaptchaApigetCaptchaEmptyRequest alloc] init];
    request.apiName = @"uc.ReCaptchaApi/getCaptcha";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucCaptchaResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end