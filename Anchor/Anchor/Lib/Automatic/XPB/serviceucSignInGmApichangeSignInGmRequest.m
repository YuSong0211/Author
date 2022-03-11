#include "serviceucSignInGmApichangeSignInGmRequest.h"
@implementation serviceucSignInGmApichangeSignInGmRequest

+( serviceucSignInGmApichangeSignInGmRequest *)createRequest
{
    serviceucSignInGmApichangeSignInGmRequest* request = [[ serviceucSignInGmApichangeSignInGmRequest alloc] init];
    request.apiName = @"uc.SignInGmApi/change";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucSignInGmRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucAccountAccessResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end