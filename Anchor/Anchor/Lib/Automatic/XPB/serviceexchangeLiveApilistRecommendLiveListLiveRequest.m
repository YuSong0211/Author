#include "serviceexchangeLiveApilistRecommendLiveListLiveRequest.h"
@implementation serviceexchangeLiveApilistRecommendLiveListLiveRequest

+( serviceexchangeLiveApilistRecommendLiveListLiveRequest *)createRequest
{
    serviceexchangeLiveApilistRecommendLiveListLiveRequest* request = [[ serviceexchangeLiveApilistRecommendLiveListLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/listRecommendLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end