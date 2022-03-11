#include "serviceucPaymentApilookupPaymentLookupRequest.h"
@implementation serviceucPaymentApilookupPaymentLookupRequest

+( serviceucPaymentApilookupPaymentLookupRequest *)createRequest
{
    serviceucPaymentApilookupPaymentLookupRequest* request = [[ serviceucPaymentApilookupPaymentLookupRequest alloc] init];
    request.apiName = @"uc.PaymentApi/lookup";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucPaymentLookupRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucPaymentLookupResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end