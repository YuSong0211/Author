#include "appvapiPassportApiconfigConfigRequest.h"
@implementation appvapiPassportApiconfigConfigRequest

+( appvapiPassportApiconfigConfigRequest *)createRequest
{
    appvapiPassportApiconfigConfigRequest* request = [[ appvapiPassportApiconfigConfigRequest alloc] init];
    request.apiName = @"appvapi.PassportApi/config";
    request.packageName = @"appvapi";
    request.request  = [[appvapiConfigRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiConfigResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end