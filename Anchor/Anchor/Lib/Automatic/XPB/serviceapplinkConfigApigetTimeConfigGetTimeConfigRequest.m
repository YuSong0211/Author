#include "serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest.h"
@implementation serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest

+( serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest *)createRequest
{
    serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest* request = [[ serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest alloc] init];
    request.apiName = @"applink.ConfigApi/getTimeConfig";
    request.packageName = @"serviceapplink";
    request.request  = [[serviceapplinkGetTimeConfigRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceapplinkServerTime alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end