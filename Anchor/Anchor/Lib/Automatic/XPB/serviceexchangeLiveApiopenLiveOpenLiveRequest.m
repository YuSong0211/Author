#include "serviceexchangeLiveApiopenLiveOpenLiveRequest.h"
@implementation serviceexchangeLiveApiopenLiveOpenLiveRequest

+( serviceexchangeLiveApiopenLiveOpenLiveRequest *)createRequest
{
    serviceexchangeLiveApiopenLiveOpenLiveRequest* request = [[ serviceexchangeLiveApiopenLiveOpenLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/openLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeOpenLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeOpenLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end