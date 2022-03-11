#include "serviceexchangeLiveInteractiveApiliveChatLiveChatRequest.h"
@implementation serviceexchangeLiveInteractiveApiliveChatLiveChatRequest

+( serviceexchangeLiveInteractiveApiliveChatLiveChatRequest *)createRequest
{
    serviceexchangeLiveInteractiveApiliveChatLiveChatRequest* request = [[ serviceexchangeLiveInteractiveApiliveChatLiveChatRequest alloc] init];
    request.apiName = @"exchange.LiveInteractiveApi/liveChat";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeLiveChatRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end