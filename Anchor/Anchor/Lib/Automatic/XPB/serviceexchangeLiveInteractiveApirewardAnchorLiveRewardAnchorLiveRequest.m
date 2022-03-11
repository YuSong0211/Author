#include "serviceexchangeLiveInteractiveApirewardAnchorLiveRewardAnchorLiveRequest.h"
@implementation serviceexchangeLiveInteractiveApirewardAnchorLiveRewardAnchorLiveRequest

+( serviceexchangeLiveInteractiveApirewardAnchorLiveRewardAnchorLiveRequest *)createRequest
{
    serviceexchangeLiveInteractiveApirewardAnchorLiveRewardAnchorLiveRequest* request = [[ serviceexchangeLiveInteractiveApirewardAnchorLiveRewardAnchorLiveRequest alloc] init];
    request.apiName = @"exchange.LiveInteractiveApi/rewardAnchorLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeRewardAnchorLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end