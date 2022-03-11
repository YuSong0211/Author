#include "appvapiSocialCommentApireplyParentCommentCommentReplyRequest.h"
@implementation appvapiSocialCommentApireplyParentCommentCommentReplyRequest

+( appvapiSocialCommentApireplyParentCommentCommentReplyRequest *)createRequest
{
    appvapiSocialCommentApireplyParentCommentCommentReplyRequest* request = [[ appvapiSocialCommentApireplyParentCommentCommentReplyRequest alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/replyParentComment";
    request.packageName = @"appvapi";
    request.request  = [[appvapiCommentReplyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiCommentResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end