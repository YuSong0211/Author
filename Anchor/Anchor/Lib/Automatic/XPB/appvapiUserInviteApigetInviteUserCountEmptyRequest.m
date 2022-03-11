#include "appvapiUserInviteApigetInviteUserCountEmptyRequest.h"
@implementation appvapiUserInviteApigetInviteUserCountEmptyRequest

+( appvapiUserInviteApigetInviteUserCountEmptyRequest *)createRequest
{
    appvapiUserInviteApigetInviteUserCountEmptyRequest* request = [[ appvapiUserInviteApigetInviteUserCountEmptyRequest alloc] init];
    request.apiName = @"appvapi.UserInviteApi/getInviteUserCount";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiGetInviteUserCountResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end