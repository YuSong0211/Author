#include "serviceucSignInApiguestGuestRequest.h"
@implementation serviceucSignInApiguestGuestRequest

+( serviceucSignInApiguestGuestRequest *)createRequest
{
    serviceucSignInApiguestGuestRequest* request = [[ serviceucSignInApiguestGuestRequest alloc] init];
    request.apiName = @"uc.SignInApi/guest";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucGuestRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucAccountAccessResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end