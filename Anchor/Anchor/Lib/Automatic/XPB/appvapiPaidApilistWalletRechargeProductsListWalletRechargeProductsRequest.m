#include "appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest.h"
@implementation appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest

+( appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest *)createRequest
{
    appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest* request = [[ appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest alloc] init];
    request.apiName = @"appvapi.h5.PaidApi/listWalletRechargeProducts";
    request.packageName = @"appvapi";
    request.request  = [[appvapiListWalletRechargeProductsRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListWalletRechargeProductsResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end