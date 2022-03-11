#include "appvapiVisitorApivisitIndexIdEncode.h"
@implementation appvapiVisitorApivisitIndexIdEncode

+( appvapiVisitorApivisitIndexIdEncode *)createRequest
{
    appvapiVisitorApivisitIndexIdEncode* request = [[ appvapiVisitorApivisitIndexIdEncode alloc] init];
    request.apiName = @"appvapi.VisitorApi/visitIndex";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiVisitUserInfoResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end