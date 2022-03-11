#include "appvapiWorkOrderApicheckUnreadWorkOrderEmptyRequest.h"
@implementation appvapiWorkOrderApicheckUnreadWorkOrderEmptyRequest

+( appvapiWorkOrderApicheckUnreadWorkOrderEmptyRequest *)createRequest
{
    appvapiWorkOrderApicheckUnreadWorkOrderEmptyRequest* request = [[ appvapiWorkOrderApicheckUnreadWorkOrderEmptyRequest alloc] init];
    request.apiName = @"appvapi.WorkOrderApi/checkUnreadWorkOrder";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiCheckUnreadMessagesResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end