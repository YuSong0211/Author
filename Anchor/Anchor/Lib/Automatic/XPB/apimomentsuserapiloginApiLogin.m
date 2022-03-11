#include "apimomentsuserapiloginApiLogin.h"
@implementation apimomentsuserapiloginApiLogin

+( apimomentsuserapiloginApiLogin *)createRequest
{
    apimomentsuserapiloginApiLogin* request = [[ apimomentsuserapiloginApiLogin alloc] init];
    request.apiName = @"apimoments.user/apilogin";
    request.packageName = @"apimoments";
    request.request  = [[apimomentsApiLogin alloc] init];
    request.pb_request = request.request;
    request.respose = [[apimomentsEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end