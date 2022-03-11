#include "appvapiPaidApiwalletRechargeWalletRechargeRequest.h"
@implementation appvapiPaidApiwalletRechargeWalletRechargeRequest

+( appvapiPaidApiwalletRechargeWalletRechargeRequest *)createRequest
{
    appvapiPaidApiwalletRechargeWalletRechargeRequest* request = [[ appvapiPaidApiwalletRechargeWalletRechargeRequest alloc] init];
    request.apiName = @"appvapi.h5.PaidApi/walletRecharge";
    request.packageName = @"appvapi";
    request.request  = [[appvapiWalletRechargeRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiWalletRechargeResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end