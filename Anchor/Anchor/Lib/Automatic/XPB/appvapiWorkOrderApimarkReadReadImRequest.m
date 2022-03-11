#include "appvapiWorkOrderApimarkReadReadImRequest.h"
@implementation appvapiWorkOrderApimarkReadReadImRequest

+( appvapiWorkOrderApimarkReadReadImRequest *)createRequest
{
    appvapiWorkOrderApimarkReadReadImRequest* request = [[ appvapiWorkOrderApimarkReadReadImRequest alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/markRead";
    request.packageName = @"appvapi";
    request.request  = [[appvapiReadImRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end