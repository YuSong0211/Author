#include "serviceucWalletApiamountsAmountsRequest.h"
@implementation serviceucWalletApiamountsAmountsRequest

+( serviceucWalletApiamountsAmountsRequest *)createRequest
{
    serviceucWalletApiamountsAmountsRequest* request = [[ serviceucWalletApiamountsAmountsRequest alloc] init];
    request.apiName = @"uc.WalletApi/amounts";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucAmountsRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucAmountsResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end