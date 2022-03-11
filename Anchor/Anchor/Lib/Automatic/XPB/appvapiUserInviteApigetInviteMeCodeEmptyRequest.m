#include "appvapiUserInviteApigetInviteMeCodeEmptyRequest.h"
@implementation appvapiUserInviteApigetInviteMeCodeEmptyRequest

+( appvapiUserInviteApigetInviteMeCodeEmptyRequest *)createRequest
{
    appvapiUserInviteApigetInviteMeCodeEmptyRequest* request = [[ appvapiUserInviteApigetInviteMeCodeEmptyRequest alloc] init];
    request.apiName = @"appvapi.UserInviteApi/getInviteMeCode";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiGetInviteMeCodeResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end