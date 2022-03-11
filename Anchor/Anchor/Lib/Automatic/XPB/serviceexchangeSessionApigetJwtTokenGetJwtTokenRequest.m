#include "serviceexchangeSessionApigetJwtTokenGetJwtTokenRequest.h"
@implementation serviceexchangeSessionApigetJwtTokenGetJwtTokenRequest

+( serviceexchangeSessionApigetJwtTokenGetJwtTokenRequest *)createRequest
{
    serviceexchangeSessionApigetJwtTokenGetJwtTokenRequest* request = [[ serviceexchangeSessionApigetJwtTokenGetJwtTokenRequest alloc] init];
    request.apiName = @"exchange.SessionApi/getJwtToken";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeGetJwtTokenRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeGetJwtTokenResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end