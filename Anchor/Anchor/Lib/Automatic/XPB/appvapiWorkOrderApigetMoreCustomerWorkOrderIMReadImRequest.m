#include "appvapiWorkOrderApigetMoreCustomerWorkOrderIMReadImRequest.h"
@implementation appvapiWorkOrderApigetMoreCustomerWorkOrderIMReadImRequest

+( appvapiWorkOrderApigetMoreCustomerWorkOrderIMReadImRequest *)createRequest
{
    appvapiWorkOrderApigetMoreCustomerWorkOrderIMReadImRequest* request = [[ appvapiWorkOrderApigetMoreCustomerWorkOrderIMReadImRequest alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/getMoreCustomerWorkOrderIM";
    request.packageName = @"appvapi";
    request.request  = [[appvapiReadImRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListWorkOrderImResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end