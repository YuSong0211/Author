#include "serviceexchangeLiveApigetLiveBaseDataEmptyRequest.h"
@implementation serviceexchangeLiveApigetLiveBaseDataEmptyRequest

+( serviceexchangeLiveApigetLiveBaseDataEmptyRequest *)createRequest
{
    serviceexchangeLiveApigetLiveBaseDataEmptyRequest* request = [[ serviceexchangeLiveApigetLiveBaseDataEmptyRequest alloc] init];
    request.apiName = @"exchange.LiveApi/getLiveBaseData";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeGetLiveBaseDataResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end