#include "serviceucReCaptchaApivalidCaptchaCaptchaValid.h"
@implementation serviceucReCaptchaApivalidCaptchaCaptchaValid

+( serviceucReCaptchaApivalidCaptchaCaptchaValid *)createRequest
{
    serviceucReCaptchaApivalidCaptchaCaptchaValid* request = [[ serviceucReCaptchaApivalidCaptchaCaptchaValid alloc] init];
    request.apiName = @"uc.ReCaptchaApi/validCaptcha";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucCaptchaValid alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucReCaptchaValidResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end