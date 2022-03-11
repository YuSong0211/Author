#include "serviceexchangeLiveInteractiveApistarLiveStarLiveRequest.h"
@implementation serviceexchangeLiveInteractiveApistarLiveStarLiveRequest

+( serviceexchangeLiveInteractiveApistarLiveStarLiveRequest *)createRequest
{
    serviceexchangeLiveInteractiveApistarLiveStarLiveRequest* request = [[ serviceexchangeLiveInteractiveApistarLiveStarLiveRequest alloc] init];
    request.apiName = @"exchange.LiveInteractiveApi/starLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeStarLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end