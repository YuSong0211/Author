#include "appvapiUserApiupdateAvatarUpdateAvatarRequest.h"
@implementation appvapiUserApiupdateAvatarUpdateAvatarRequest

+( appvapiUserApiupdateAvatarUpdateAvatarRequest *)createRequest
{
    appvapiUserApiupdateAvatarUpdateAvatarRequest* request = [[ appvapiUserApiupdateAvatarUpdateAvatarRequest alloc] init];
    request.apiName = @"appvapi.UserApi/updateAvatar";
    request.packageName = @"appvapi";
    request.request  = [[appvapiUpdateAvatarRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiOssEvents alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end