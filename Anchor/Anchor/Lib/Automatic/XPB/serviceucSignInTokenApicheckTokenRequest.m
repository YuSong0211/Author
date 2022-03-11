#include "serviceucSignInTokenApicheckTokenRequest.h"
@implementation serviceucSignInTokenApicheckTokenRequest

+( serviceucSignInTokenApicheckTokenRequest *)createRequest
{
    serviceucSignInTokenApicheckTokenRequest* request = [[ serviceucSignInTokenApicheckTokenRequest alloc] init];
    request.apiName = @"uc.SignInTokenApi/check";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucTokenRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucAccountAccessResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end