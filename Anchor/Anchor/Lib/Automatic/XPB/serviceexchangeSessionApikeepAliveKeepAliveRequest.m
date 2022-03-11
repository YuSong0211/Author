#include "serviceexchangeSessionApikeepAliveKeepAliveRequest.h"
@implementation serviceexchangeSessionApikeepAliveKeepAliveRequest

+( serviceexchangeSessionApikeepAliveKeepAliveRequest *)createRequest
{
    serviceexchangeSessionApikeepAliveKeepAliveRequest* request = [[ serviceexchangeSessionApikeepAliveKeepAliveRequest alloc] init];
    request.apiName = @"exchange.SessionApi/keepAlive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeKeepAliveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeKeepAliveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end