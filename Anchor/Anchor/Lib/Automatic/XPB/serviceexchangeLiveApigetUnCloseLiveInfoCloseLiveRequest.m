#include "serviceexchangeLiveApigetUnCloseLiveInfoCloseLiveRequest.h"
@implementation serviceexchangeLiveApigetUnCloseLiveInfoCloseLiveRequest

+( serviceexchangeLiveApigetUnCloseLiveInfoCloseLiveRequest *)createRequest
{
    serviceexchangeLiveApigetUnCloseLiveInfoCloseLiveRequest* request = [[ serviceexchangeLiveApigetUnCloseLiveInfoCloseLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/getUnCloseLiveInfo";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeCloseLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeGetUnCloseLiveInfoResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end