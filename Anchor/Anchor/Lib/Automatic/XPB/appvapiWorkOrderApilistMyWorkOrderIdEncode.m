#include "appvapiWorkOrderApilistMyWorkOrderIdEncode.h"
@implementation appvapiWorkOrderApilistMyWorkOrderIdEncode

+( appvapiWorkOrderApilistMyWorkOrderIdEncode *)createRequest
{
    appvapiWorkOrderApilistMyWorkOrderIdEncode* request = [[ appvapiWorkOrderApilistMyWorkOrderIdEncode alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/listMyWorkOrder";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListMyWorkOrderResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end