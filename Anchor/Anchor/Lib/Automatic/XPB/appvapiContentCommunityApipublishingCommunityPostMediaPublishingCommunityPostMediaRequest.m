#include "appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest.h"
@implementation appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest

+( appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest *)createRequest
{
    appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest* request = [[ appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest alloc] init];
    request.apiName = @"appvapi.ContentCommunityApi/publishingCommunityPostMedia";
    request.packageName = @"appvapi";
    request.request  = [[appvapiPublishingCommunityPostMediaRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiOssEvents alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end