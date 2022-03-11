#include "serviceexchangeLiveApilistLiveListLiveRequest.h"
@implementation serviceexchangeLiveApilistLiveListLiveRequest

+( serviceexchangeLiveApilistLiveListLiveRequest *)createRequest
{
    serviceexchangeLiveApilistLiveListLiveRequest* request = [[ serviceexchangeLiveApilistLiveListLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/listLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end