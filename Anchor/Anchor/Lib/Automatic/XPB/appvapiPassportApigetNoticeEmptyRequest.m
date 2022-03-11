#include "appvapiPassportApigetNoticeEmptyRequest.h"
@implementation appvapiPassportApigetNoticeEmptyRequest

+( appvapiPassportApigetNoticeEmptyRequest *)createRequest
{
    appvapiPassportApigetNoticeEmptyRequest* request = [[ appvapiPassportApigetNoticeEmptyRequest alloc] init];
    request.apiName = @"appvapi.PassportApi/getNotice";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiGetNoticeResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end