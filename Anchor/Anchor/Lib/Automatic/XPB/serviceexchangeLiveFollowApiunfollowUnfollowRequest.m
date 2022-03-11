#include "serviceexchangeLiveFollowApiunfollowUnfollowRequest.h"
@implementation serviceexchangeLiveFollowApiunfollowUnfollowRequest

+( serviceexchangeLiveFollowApiunfollowUnfollowRequest *)createRequest
{
    serviceexchangeLiveFollowApiunfollowUnfollowRequest* request = [[ serviceexchangeLiveFollowApiunfollowUnfollowRequest alloc] init];
    request.apiName = @"exchange.LiveFollowApi/unfollow";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeUnfollowRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end