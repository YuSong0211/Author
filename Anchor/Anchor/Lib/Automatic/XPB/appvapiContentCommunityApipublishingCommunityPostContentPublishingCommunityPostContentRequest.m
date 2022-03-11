#include "appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest.h"
@implementation appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest

+( appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest *)createRequest
{
    appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest* request = [[ appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest alloc] init];
    request.apiName = @"appvapi.ContentCommunityApi/publishingCommunityPostContent";
    request.packageName = @"appvapi";
    request.request  = [[appvapiPublishingCommunityPostContentRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiIdEncode alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end