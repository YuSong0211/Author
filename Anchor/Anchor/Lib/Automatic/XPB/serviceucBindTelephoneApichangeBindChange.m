#include "serviceucBindTelephoneApichangeBindChange.h"
@implementation serviceucBindTelephoneApichangeBindChange

+( serviceucBindTelephoneApichangeBindChange *)createRequest
{
    serviceucBindTelephoneApichangeBindChange* request = [[ serviceucBindTelephoneApichangeBindChange alloc] init];
    request.apiName = @"uc.BindTelephoneApi/change";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucBindChange alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end