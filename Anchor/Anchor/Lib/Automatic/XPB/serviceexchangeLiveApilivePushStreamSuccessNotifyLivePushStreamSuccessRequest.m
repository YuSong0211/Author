#include "serviceexchangeLiveApilivePushStreamSuccessNotifyLivePushStreamSuccessRequest.h"
@implementation serviceexchangeLiveApilivePushStreamSuccessNotifyLivePushStreamSuccessRequest

+( serviceexchangeLiveApilivePushStreamSuccessNotifyLivePushStreamSuccessRequest *)createRequest
{
    serviceexchangeLiveApilivePushStreamSuccessNotifyLivePushStreamSuccessRequest* request = [[ serviceexchangeLiveApilivePushStreamSuccessNotifyLivePushStreamSuccessRequest alloc] init];
    request.apiName = @"exchange.LiveApi/livePushStreamSuccessNotify";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeLivePushStreamSuccessRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end