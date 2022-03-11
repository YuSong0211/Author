#include "appvapiWorkOrderApicreateWorkOrderInstantMessageWorkOrderInstantMessage.h"
@implementation appvapiWorkOrderApicreateWorkOrderInstantMessageWorkOrderInstantMessage

+( appvapiWorkOrderApicreateWorkOrderInstantMessageWorkOrderInstantMessage *)createRequest
{
    appvapiWorkOrderApicreateWorkOrderInstantMessageWorkOrderInstantMessage* request = [[ appvapiWorkOrderApicreateWorkOrderInstantMessageWorkOrderInstantMessage alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/createWorkOrderInstantMessage";
    request.packageName = @"appvapi";
    request.request  = [[appvapiWorkOrderInstantMessage alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end