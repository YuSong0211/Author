#include "appvapiUserInviteApireceiveInviteReceiveInviteRequest.h"
@implementation appvapiUserInviteApireceiveInviteReceiveInviteRequest

+( appvapiUserInviteApireceiveInviteReceiveInviteRequest *)createRequest
{
    appvapiUserInviteApireceiveInviteReceiveInviteRequest* request = [[ appvapiUserInviteApireceiveInviteReceiveInviteRequest alloc] init];
    request.apiName = @"appvapi.UserInviteApi/receiveInvite";
    request.packageName = @"appvapi";
    request.request  = [[appvapiReceiveInviteRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end