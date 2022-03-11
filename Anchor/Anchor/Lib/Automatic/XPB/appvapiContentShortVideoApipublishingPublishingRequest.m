#include "appvapiContentShortVideoApipublishingPublishingRequest.h"
@implementation appvapiContentShortVideoApipublishingPublishingRequest

+( appvapiContentShortVideoApipublishingPublishingRequest *)createRequest
{
    appvapiContentShortVideoApipublishingPublishingRequest* request = [[ appvapiContentShortVideoApipublishingPublishingRequest alloc] init];
    request.apiName = @"appvapi.ContentShortVideoApi/publishing";
    request.packageName = @"appvapi";
    request.request  = [[appvapiPublishingRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiOssEvents alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end