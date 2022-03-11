#include "serviceucSignApioutSignOutRequest.h"
@implementation serviceucSignApioutSignOutRequest

+( serviceucSignApioutSignOutRequest *)createRequest
{
    serviceucSignApioutSignOutRequest* request = [[ serviceucSignApioutSignOutRequest alloc] init];
    request.apiName = @"uc.SignApi/out";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucSignOutRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucSignOutResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end