#include "serviceucClientsApiuuidUuidRequest.h"
@implementation serviceucClientsApiuuidUuidRequest

+( serviceucClientsApiuuidUuidRequest *)createRequest
{
    serviceucClientsApiuuidUuidRequest* request = [[ serviceucClientsApiuuidUuidRequest alloc] init];
    request.apiName = @"uc.ClientsApi/uuid";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucUuidRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucUuidResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end