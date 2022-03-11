#include "serviceexchangeGroupApilistChatGroupListChatGroupRequest.h"
@implementation serviceexchangeGroupApilistChatGroupListChatGroupRequest

+( serviceexchangeGroupApilistChatGroupListChatGroupRequest *)createRequest
{
    serviceexchangeGroupApilistChatGroupListChatGroupRequest* request = [[ serviceexchangeGroupApilistChatGroupListChatGroupRequest alloc] init];
    request.apiName = @"exchange.GroupApi/listChatGroup";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListChatGroupRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListChatGroupResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end