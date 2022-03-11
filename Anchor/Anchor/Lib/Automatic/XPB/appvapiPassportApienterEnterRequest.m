#include "appvapiPassportApienterEnterRequest.h"
@implementation appvapiPassportApienterEnterRequest

+( appvapiPassportApienterEnterRequest *)createRequest
{
    appvapiPassportApienterEnterRequest* request = [[ appvapiPassportApienterEnterRequest alloc] init];
    request.apiName = @"appvapi.PassportApi/enter";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEnterRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEnterResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end