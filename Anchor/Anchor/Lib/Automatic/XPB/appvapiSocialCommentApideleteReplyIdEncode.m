#include "appvapiSocialCommentApideleteReplyIdEncode.h"
@implementation appvapiSocialCommentApideleteReplyIdEncode

+( appvapiSocialCommentApideleteReplyIdEncode *)createRequest
{
    appvapiSocialCommentApideleteReplyIdEncode* request = [[ appvapiSocialCommentApideleteReplyIdEncode alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/deleteReply";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end