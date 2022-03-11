#include "serviceexchangeLiveApianchorLeaveLiveAnchorLeaveLiveRequest.h"
@implementation serviceexchangeLiveApianchorLeaveLiveAnchorLeaveLiveRequest

+( serviceexchangeLiveApianchorLeaveLiveAnchorLeaveLiveRequest *)createRequest
{
    serviceexchangeLiveApianchorLeaveLiveAnchorLeaveLiveRequest* request = [[ serviceexchangeLiveApianchorLeaveLiveAnchorLeaveLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/anchorLeaveLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeAnchorLeaveLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end