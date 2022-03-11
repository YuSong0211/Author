#include "serviceucSignInApitelephoneTelephoneSignInRequest.h"
@implementation serviceucSignInApitelephoneTelephoneSignInRequest

+( serviceucSignInApitelephoneTelephoneSignInRequest *)createRequest
{
    serviceucSignInApitelephoneTelephoneSignInRequest* request = [[ serviceucSignInApitelephoneTelephoneSignInRequest alloc] init];
    request.apiName = @"uc.SignInApi/telephone";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucTelephoneSignInRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucAccountAccessResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end