#include "serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest.h"
@implementation serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest

+( serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest *)createRequest
{
    serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest* request = [[ serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest alloc] init];
    request.apiName = @"exchange.TemplateMsgApi/listTemplateMsg";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListTemplateMsgRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListTemplateMsgResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end