#include "serviceexchangeLiveApiliveUserListLiveUserListRequest.h"
@implementation serviceexchangeLiveApiliveUserListLiveUserListRequest

+( serviceexchangeLiveApiliveUserListLiveUserListRequest *)createRequest
{
    serviceexchangeLiveApiliveUserListLiveUserListRequest* request = [[ serviceexchangeLiveApiliveUserListLiveUserListRequest alloc] init];
    request.apiName = @"exchange.LiveApi/liveUserList";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeLiveUserListRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeLiveUserListResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end