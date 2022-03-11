#include "appvapiWorkOrderApiworkOrderDetailIdEncode.h"
@implementation appvapiWorkOrderApiworkOrderDetailIdEncode

+( appvapiWorkOrderApiworkOrderDetailIdEncode *)createRequest
{
    appvapiWorkOrderApiworkOrderDetailIdEncode* request = [[ appvapiWorkOrderApiworkOrderDetailIdEncode alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/workOrderDetail";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiWorkOrderDetailResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end