#include "appvapiSocialCommentApiunlikeIdEncode.h"
@implementation appvapiSocialCommentApiunlikeIdEncode

+( appvapiSocialCommentApiunlikeIdEncode *)createRequest
{
    appvapiSocialCommentApiunlikeIdEncode* request = [[ appvapiSocialCommentApiunlikeIdEncode alloc] init];
    request.apiName = @"appvapi.SocialCommentApi/unlike";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end