#include "serviceexchangeLiveApilistLiveByTagListLiveByTagRequest.h"
@implementation serviceexchangeLiveApilistLiveByTagListLiveByTagRequest

+( serviceexchangeLiveApilistLiveByTagListLiveByTagRequest *)createRequest
{
    serviceexchangeLiveApilistLiveByTagListLiveByTagRequest* request = [[ serviceexchangeLiveApilistLiveByTagListLiveByTagRequest alloc] init];
    request.apiName = @"exchange.LiveApi/listLiveByTag";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListLiveByTagRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListLiveByTagResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end