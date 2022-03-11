#include "appvapiSocialCommentApilikeReplyIdEncode.h"
@implementation appvapiSocialCommentApilikeReplyIdEncode

+( appvapiSocialCommentApilikeReplyIdEncode *)createRequest
{
    appvapiSocialCommentApilikeReplyIdEncode* request = [[ appvapiSocialCommentApilikeReplyIdEncode alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/likeReply";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiIdEncode alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end