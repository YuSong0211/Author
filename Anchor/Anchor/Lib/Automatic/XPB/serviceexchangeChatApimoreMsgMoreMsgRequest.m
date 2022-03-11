#include "serviceexchangeChatApimoreMsgMoreMsgRequest.h"
@implementation serviceexchangeChatApimoreMsgMoreMsgRequest

+( serviceexchangeChatApimoreMsgMoreMsgRequest *)createRequest
{
    serviceexchangeChatApimoreMsgMoreMsgRequest* request = [[ serviceexchangeChatApimoreMsgMoreMsgRequest alloc] init];
    request.apiName = @"exchange.ChatApi/moreMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeMoreMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeMoreMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end