#include "serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest.h"
@implementation serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest

+( serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest *)createRequest
{
    serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest* request = [[ serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest alloc] init];
    request.apiName = @"uc.ReCaptchaApi/validAliyun";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucReCaptchaValidAliyunRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucReCaptchaValidResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end