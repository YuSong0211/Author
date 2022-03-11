#include "serviceexchangeLiveApiexitLiveRoomExitLiveRoomRequest.h"
@implementation serviceexchangeLiveApiexitLiveRoomExitLiveRoomRequest

+( serviceexchangeLiveApiexitLiveRoomExitLiveRoomRequest *)createRequest
{
    serviceexchangeLiveApiexitLiveRoomExitLiveRoomRequest* request = [[ serviceexchangeLiveApiexitLiveRoomExitLiveRoomRequest alloc] init];
    request.apiName = @"exchange.LiveApi/exitLiveRoom";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeExitLiveRoomRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end