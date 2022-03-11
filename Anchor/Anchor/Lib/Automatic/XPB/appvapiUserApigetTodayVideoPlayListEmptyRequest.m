#include "appvapiUserApigetTodayVideoPlayListEmptyRequest.h"
@implementation appvapiUserApigetTodayVideoPlayListEmptyRequest

+( appvapiUserApigetTodayVideoPlayListEmptyRequest *)createRequest
{
    appvapiUserApigetTodayVideoPlayListEmptyRequest* request = [[ appvapiUserApigetTodayVideoPlayListEmptyRequest alloc] init];
    request.apiName = @"appvapi.UserApi/getTodayVideoPlayList";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiVideoPlayListResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end