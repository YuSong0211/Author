#include "appvapiOssApiuploadCallbackCallbackMessageReq.h"
@implementation appvapiOssApiuploadCallbackCallbackMessageReq

+( appvapiOssApiuploadCallbackCallbackMessageReq *)createRequest
{
    appvapiOssApiuploadCallbackCallbackMessageReq* request = [[ appvapiOssApiuploadCallbackCallbackMessageReq alloc] init];
    request.apiName = @"appvapi.OssApi/uploadCallback";
    request.packageName = @"appvapi";
    request.request  = [[appvapiCallbackMessageReq alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiUploadCallbackResp alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end