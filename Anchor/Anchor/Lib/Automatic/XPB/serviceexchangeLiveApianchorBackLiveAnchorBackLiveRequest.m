#include "serviceexchangeLiveApianchorBackLiveAnchorBackLiveRequest.h"
@implementation serviceexchangeLiveApianchorBackLiveAnchorBackLiveRequest

+( serviceexchangeLiveApianchorBackLiveAnchorBackLiveRequest *)createRequest
{
    serviceexchangeLiveApianchorBackLiveAnchorBackLiveRequest* request = [[ serviceexchangeLiveApianchorBackLiveAnchorBackLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/anchorBackLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeAnchorBackLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end