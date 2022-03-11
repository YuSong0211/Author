#include "serviceexchangeAnchorApiapplyLiveApplyLiveRequest.h"
@implementation serviceexchangeAnchorApiapplyLiveApplyLiveRequest

+( serviceexchangeAnchorApiapplyLiveApplyLiveRequest *)createRequest
{
    serviceexchangeAnchorApiapplyLiveApplyLiveRequest* request = [[ serviceexchangeAnchorApiapplyLiveApplyLiveRequest alloc] init];
    request.apiName = @"exchange.AnchorApi/applyLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeApplyLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end