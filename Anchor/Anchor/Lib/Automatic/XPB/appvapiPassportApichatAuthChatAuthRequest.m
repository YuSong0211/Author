#include "appvapiPassportApichatAuthChatAuthRequest.h"
@implementation appvapiPassportApichatAuthChatAuthRequest

+( appvapiPassportApichatAuthChatAuthRequest *)createRequest
{
    appvapiPassportApichatAuthChatAuthRequest* request = [[ appvapiPassportApichatAuthChatAuthRequest alloc] init];
    request.apiName = @"appvapi.PassportApi/chatAuth";
    request.packageName = @"appvapi";
    request.request  = [[appvapiChatAuthRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiChatAuthResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end