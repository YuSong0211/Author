#include "serviceexchangeLiveUserApigetLiveAnchorInfoGetLiveAnchorInfoRequest.h"
@implementation serviceexchangeLiveUserApigetLiveAnchorInfoGetLiveAnchorInfoRequest

+( serviceexchangeLiveUserApigetLiveAnchorInfoGetLiveAnchorInfoRequest *)createRequest
{
    serviceexchangeLiveUserApigetLiveAnchorInfoGetLiveAnchorInfoRequest* request = [[ serviceexchangeLiveUserApigetLiveAnchorInfoGetLiveAnchorInfoRequest alloc] init];
    request.apiName = @"exchange.LiveUserApi/getLiveAnchorInfo";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeGetLiveAnchorInfoRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeGetLiveUserInfoResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end