#include "serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest.h"
@implementation serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest

+( serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest *)createRequest
{
    serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest* request = [[ serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest alloc] init];
    request.apiName = @"exchange.TemplateMsgApi/readTemplate";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeReadTemplateRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeReadTemplateResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end