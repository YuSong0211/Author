#include "serviceapplinkLinkPassportApicheckLastedCheckLastedRequest.h"
@implementation serviceapplinkLinkPassportApicheckLastedCheckLastedRequest

+( serviceapplinkLinkPassportApicheckLastedCheckLastedRequest *)createRequest
{
    serviceapplinkLinkPassportApicheckLastedCheckLastedRequest* request = [[ serviceapplinkLinkPassportApicheckLastedCheckLastedRequest alloc] init];
    request.apiName = @"applink.LinkPassportApi/checkLasted";
    request.packageName = @"serviceapplink";
    request.request  = [[serviceapplinkCheckLastedRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceapplinkCheckLastedResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end