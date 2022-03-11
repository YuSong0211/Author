#include "serviceexchangeLiveApilistMyFollowLiveListMyFollowLiveRequest.h"
@implementation serviceexchangeLiveApilistMyFollowLiveListMyFollowLiveRequest

+( serviceexchangeLiveApilistMyFollowLiveListMyFollowLiveRequest *)createRequest
{
    serviceexchangeLiveApilistMyFollowLiveListMyFollowLiveRequest* request = [[ serviceexchangeLiveApilistMyFollowLiveListMyFollowLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/listMyFollowLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListMyFollowLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListMyFollowLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end