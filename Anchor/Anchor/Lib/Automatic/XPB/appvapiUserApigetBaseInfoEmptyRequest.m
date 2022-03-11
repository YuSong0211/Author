#include "appvapiUserApigetBaseInfoEmptyRequest.h"
@implementation appvapiUserApigetBaseInfoEmptyRequest

+( appvapiUserApigetBaseInfoEmptyRequest *)createRequest
{
    appvapiUserApigetBaseInfoEmptyRequest* request = [[ appvapiUserApigetBaseInfoEmptyRequest alloc] init];
    request.apiName = @"appvapi.UserApi/getBaseInfo";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiUserInfoBasic alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end