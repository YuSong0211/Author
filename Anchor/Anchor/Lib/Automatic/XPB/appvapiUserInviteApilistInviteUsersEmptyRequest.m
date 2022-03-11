#include "appvapiUserInviteApilistInviteUsersEmptyRequest.h"
@implementation appvapiUserInviteApilistInviteUsersEmptyRequest

+( appvapiUserInviteApilistInviteUsersEmptyRequest *)createRequest
{
    appvapiUserInviteApilistInviteUsersEmptyRequest* request = [[ appvapiUserInviteApilistInviteUsersEmptyRequest alloc] init];
    request.apiName = @"appvapi.UserInviteApi/listInviteUsers";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListInviteUsersResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end