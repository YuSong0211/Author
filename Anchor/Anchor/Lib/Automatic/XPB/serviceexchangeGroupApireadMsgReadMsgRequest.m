#include "serviceexchangeGroupApireadMsgReadMsgRequest.h"
@implementation serviceexchangeGroupApireadMsgReadMsgRequest

+( serviceexchangeGroupApireadMsgReadMsgRequest *)createRequest
{
    serviceexchangeGroupApireadMsgReadMsgRequest* request = [[ serviceexchangeGroupApireadMsgReadMsgRequest alloc] init];
    request.apiName = @"exchange.GroupApi/readMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeReadMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeReadMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end