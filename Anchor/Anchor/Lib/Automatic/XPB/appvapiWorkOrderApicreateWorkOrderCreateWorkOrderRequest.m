#include "appvapiWorkOrderApicreateWorkOrderCreateWorkOrderRequest.h"
@implementation appvapiWorkOrderApicreateWorkOrderCreateWorkOrderRequest

+( appvapiWorkOrderApicreateWorkOrderCreateWorkOrderRequest *)createRequest
{
    appvapiWorkOrderApicreateWorkOrderCreateWorkOrderRequest* request = [[ appvapiWorkOrderApicreateWorkOrderCreateWorkOrderRequest alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/createWorkOrder";
    request.packageName = @"appvapi";
    request.request  = [[appvapiCreateWorkOrderRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiCreateWorkOrderResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end