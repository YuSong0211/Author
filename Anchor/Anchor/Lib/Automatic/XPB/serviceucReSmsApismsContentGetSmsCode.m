#include "serviceucReSmsApismsContentGetSmsCode.h"
@implementation serviceucReSmsApismsContentGetSmsCode

+( serviceucReSmsApismsContentGetSmsCode *)createRequest
{
    serviceucReSmsApismsContentGetSmsCode* request = [[ serviceucReSmsApismsContentGetSmsCode alloc] init];
    request.apiName = @"uc.ReSmsApi/smsContent";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucGetSmsCode alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucSmsCodeResp alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end