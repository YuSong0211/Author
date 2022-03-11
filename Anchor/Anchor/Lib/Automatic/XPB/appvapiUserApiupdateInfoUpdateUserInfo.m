#include "appvapiUserApiupdateInfoUpdateUserInfo.h"
@implementation appvapiUserApiupdateInfoUpdateUserInfo

+( appvapiUserApiupdateInfoUpdateUserInfo *)createRequest
{
    appvapiUserApiupdateInfoUpdateUserInfo* request = [[ appvapiUserApiupdateInfoUpdateUserInfo alloc] init];
    request.apiName = @"appvapi.UserApi/updateInfo";
    request.packageName = @"appvapi";
    request.request  = [[appvapiUpdateUserInfo alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end