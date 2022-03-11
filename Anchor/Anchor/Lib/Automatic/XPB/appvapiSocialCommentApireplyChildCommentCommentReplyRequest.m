#include "appvapiSocialCommentApireplyChildCommentCommentReplyRequest.h"
@implementation appvapiSocialCommentApireplyChildCommentCommentReplyRequest

+( appvapiSocialCommentApireplyChildCommentCommentReplyRequest *)createRequest
{
    appvapiSocialCommentApireplyChildCommentCommentReplyRequest* request = [[ appvapiSocialCommentApireplyChildCommentCommentReplyRequest alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/replyChildComment";
    request.packageName = @"appvapi";
    request.request  = [[appvapiCommentReplyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiCommentResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end