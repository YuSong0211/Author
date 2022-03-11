#include "appvapiSearchApisearchUserSearchUserRequest.h"
@implementation appvapiSearchApisearchUserSearchUserRequest

+( appvapiSearchApisearchUserSearchUserRequest *)createRequest
{
    appvapiSearchApisearchUserSearchUserRequest* request = [[ appvapiSearchApisearchUserSearchUserRequest alloc] init];
    request.apiName = @"appvapi.SearchApi/searchUser";
    request.packageName = @"appvapi";
    request.request  = [[appvapiSearchUserRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiSearchUserResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end