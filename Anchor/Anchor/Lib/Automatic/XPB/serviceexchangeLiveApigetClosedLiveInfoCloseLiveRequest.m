#include "serviceexchangeLiveApigetClosedLiveInfoCloseLiveRequest.h"
@implementation serviceexchangeLiveApigetClosedLiveInfoCloseLiveRequest

+( serviceexchangeLiveApigetClosedLiveInfoCloseLiveRequest *)createRequest
{
    serviceexchangeLiveApigetClosedLiveInfoCloseLiveRequest* request = [[ serviceexchangeLiveApigetClosedLiveInfoCloseLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/getClosedLiveInfo";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeCloseLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeCloseLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end