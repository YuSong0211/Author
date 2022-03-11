#include "serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest.h"
@implementation serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest

+( serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest *)createRequest
{
    serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest* request = [[ serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest alloc] init];
    request.apiName = @"exchange.LiveUserApi/getLiveAudienceInfo";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeGetLiveAudienceInfoRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeGetLiveUserInfoResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end