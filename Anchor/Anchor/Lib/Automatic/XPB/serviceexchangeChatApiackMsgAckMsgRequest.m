#include "serviceexchangeChatApiackMsgAckMsgRequest.h"
@implementation serviceexchangeChatApiackMsgAckMsgRequest

+( serviceexchangeChatApiackMsgAckMsgRequest *)createRequest
{
    serviceexchangeChatApiackMsgAckMsgRequest* request = [[ serviceexchangeChatApiackMsgAckMsgRequest alloc] init];
    request.apiName = @"exchange.ChatApi/ackMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeAckMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeAckMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end