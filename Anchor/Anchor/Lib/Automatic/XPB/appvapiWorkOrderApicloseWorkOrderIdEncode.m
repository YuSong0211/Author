#include "appvapiWorkOrderApicloseWorkOrderIdEncode.h"
@implementation appvapiWorkOrderApicloseWorkOrderIdEncode

+( appvapiWorkOrderApicloseWorkOrderIdEncode *)createRequest
{
    appvapiWorkOrderApicloseWorkOrderIdEncode* request = [[ appvapiWorkOrderApicloseWorkOrderIdEncode alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/closeWorkOrder";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end