#include "serviceucReSmsApicheckVerificationCodeSmsValid.h"
@implementation serviceucReSmsApicheckVerificationCodeSmsValid

+( serviceucReSmsApicheckVerificationCodeSmsValid *)createRequest
{
    serviceucReSmsApicheckVerificationCodeSmsValid* request = [[ serviceucReSmsApicheckVerificationCodeSmsValid alloc] init];
    request.apiName = @"uc.ReSmsApi/checkVerificationCode";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucSmsValid alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end