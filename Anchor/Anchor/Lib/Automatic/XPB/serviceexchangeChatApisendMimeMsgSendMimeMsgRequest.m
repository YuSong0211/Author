#include "serviceexchangeChatApisendMimeMsgSendMimeMsgRequest.h"
@implementation serviceexchangeChatApisendMimeMsgSendMimeMsgRequest

+( serviceexchangeChatApisendMimeMsgSendMimeMsgRequest *)createRequest
{
    serviceexchangeChatApisendMimeMsgSendMimeMsgRequest* request = [[ serviceexchangeChatApisendMimeMsgSendMimeMsgRequest alloc] init];
    request.apiName = @"exchange.ChatApi/sendMimeMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeSendMimeMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeSendMimeMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end