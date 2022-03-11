#include "serviceexchangeGroupApiremoveGroupRemoveGroupRequest.h"
@implementation serviceexchangeGroupApiremoveGroupRemoveGroupRequest

+( serviceexchangeGroupApiremoveGroupRemoveGroupRequest *)createRequest
{
    serviceexchangeGroupApiremoveGroupRemoveGroupRequest* request = [[ serviceexchangeGroupApiremoveGroupRemoveGroupRequest alloc] init];
    request.apiName = @"exchange.GroupApi/removeGroup";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeRemoveGroupRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeRemoveGroupResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end