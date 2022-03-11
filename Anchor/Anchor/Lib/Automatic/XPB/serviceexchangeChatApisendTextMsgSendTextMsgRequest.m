#include "serviceexchangeChatApisendTextMsgSendTextMsgRequest.h"
@implementation serviceexchangeChatApisendTextMsgSendTextMsgRequest

+( serviceexchangeChatApisendTextMsgSendTextMsgRequest *)createRequest
{
    serviceexchangeChatApisendTextMsgSendTextMsgRequest* request = [[ serviceexchangeChatApisendTextMsgSendTextMsgRequest alloc] init];
    request.apiName = @"exchange.ChatApi/sendTextMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeSendTextMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeSendTextMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end