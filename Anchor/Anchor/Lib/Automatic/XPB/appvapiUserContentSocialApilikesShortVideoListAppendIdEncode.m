#include "appvapiUserContentSocialApilikesShortVideoListAppendIdEncode.h"
@implementation appvapiUserContentSocialApilikesShortVideoListAppendIdEncode

+( appvapiUserContentSocialApilikesShortVideoListAppendIdEncode *)createRequest
{
    appvapiUserContentSocialApilikesShortVideoListAppendIdEncode* request = [[ appvapiUserContentSocialApilikesShortVideoListAppendIdEncode alloc] init];
    request.apiName = @"appvapi.UserContentSocialApi/likesShortVideoList";
    request.packageName = @"appvapi";
    request.request  = [[appvapiAppendIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiLikesShortVideoListResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end