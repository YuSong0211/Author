#include "appvapiUserContentApimyShortVideoListAppendIdEncode.h"
@implementation appvapiUserContentApimyShortVideoListAppendIdEncode

+( appvapiUserContentApimyShortVideoListAppendIdEncode *)createRequest
{
    appvapiUserContentApimyShortVideoListAppendIdEncode* request = [[ appvapiUserContentApimyShortVideoListAppendIdEncode alloc] init];
    request.apiName = @"appvapi.UserContentApi/myShortVideoList";
    request.packageName = @"appvapi";
    request.request  = [[appvapiAppendIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiMyContentSvideoAppendList alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end