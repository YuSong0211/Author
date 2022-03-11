#include "serviceexchangeLiveFollowApifollowFollowRequest.h"
@implementation serviceexchangeLiveFollowApifollowFollowRequest

+( serviceexchangeLiveFollowApifollowFollowRequest *)createRequest
{
    serviceexchangeLiveFollowApifollowFollowRequest* request = [[ serviceexchangeLiveFollowApifollowFollowRequest alloc] init];
    request.apiName = @"exchange.LiveFollowApi/follow";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeFollowRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end