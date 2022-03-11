#include "serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest.h"
@implementation serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest

+( serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest *)createRequest
{
    serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest* request = [[ serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest alloc] init];
    request.apiName = @"uc.PaymentAppleApi/verifyReceipt";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucPaymentAppleVerifyReceiptRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucPaymentAppleVerifyReceiptResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end