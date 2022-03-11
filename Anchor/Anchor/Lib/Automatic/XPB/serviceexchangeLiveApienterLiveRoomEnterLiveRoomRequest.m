#include "serviceexchangeLiveApienterLiveRoomEnterLiveRoomRequest.h"
@implementation serviceexchangeLiveApienterLiveRoomEnterLiveRoomRequest

+( serviceexchangeLiveApienterLiveRoomEnterLiveRoomRequest *)createRequest
{
    serviceexchangeLiveApienterLiveRoomEnterLiveRoomRequest* request = [[ serviceexchangeLiveApienterLiveRoomEnterLiveRoomRequest alloc] init];
    request.apiName = @"exchange.LiveApi/enterLiveRoom";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeEnterLiveRoomRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEnterLiveRoomResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end