#include "serviceexchangeAnchorApianchorPersonalCenterEmptyRequest.h"
@implementation serviceexchangeAnchorApianchorPersonalCenterEmptyRequest

+( serviceexchangeAnchorApianchorPersonalCenterEmptyRequest *)createRequest
{
    serviceexchangeAnchorApianchorPersonalCenterEmptyRequest* request = [[ serviceexchangeAnchorApianchorPersonalCenterEmptyRequest alloc] init];
    request.apiName = @"exchange.AnchorApi/anchorPersonalCenter";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeAnchorPersonalCenterResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end