#include "appvapiPassportApienterV2EnterRequest.h"
@implementation appvapiPassportApienterV2EnterRequest

+( appvapiPassportApienterV2EnterRequest *)createRequest
{
    appvapiPassportApienterV2EnterRequest* request = [[ appvapiPassportApienterV2EnterRequest alloc] init];
    request.apiName = @"appvapi.PassportApi/enterV2";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEnterRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEnterResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end