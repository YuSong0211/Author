#include "serviceexchangeLiveApicloseLiveCloseLiveRequest.h"
@implementation serviceexchangeLiveApicloseLiveCloseLiveRequest

+( serviceexchangeLiveApicloseLiveCloseLiveRequest *)createRequest
{
    serviceexchangeLiveApicloseLiveCloseLiveRequest* request = [[ serviceexchangeLiveApicloseLiveCloseLiveRequest alloc] init];
    request.apiName = @"exchange.LiveApi/closeLive";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeCloseLiveRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeCloseLiveResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end