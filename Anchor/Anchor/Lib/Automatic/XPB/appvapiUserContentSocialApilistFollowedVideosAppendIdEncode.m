#include "appvapiUserContentSocialApilistFollowedVideosAppendIdEncode.h"
@implementation appvapiUserContentSocialApilistFollowedVideosAppendIdEncode

+( appvapiUserContentSocialApilistFollowedVideosAppendIdEncode *)createRequest
{
    appvapiUserContentSocialApilistFollowedVideosAppendIdEncode* request = [[ appvapiUserContentSocialApilistFollowedVideosAppendIdEncode alloc] init];
    request.apiName = @"appvapi.UserContentSocialApi/listFollowedVideos";
    request.packageName = @"appvapi";
    request.request  = [[appvapiAppendIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiContentSvideoAppendList alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end