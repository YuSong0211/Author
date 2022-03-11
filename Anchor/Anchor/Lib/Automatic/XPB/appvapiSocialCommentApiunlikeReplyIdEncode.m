#include "appvapiSocialCommentApiunlikeReplyIdEncode.h"
@implementation appvapiSocialCommentApiunlikeReplyIdEncode

+( appvapiSocialCommentApiunlikeReplyIdEncode *)createRequest
{
    appvapiSocialCommentApiunlikeReplyIdEncode* request = [[ appvapiSocialCommentApiunlikeReplyIdEncode alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/unlikeReply";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end