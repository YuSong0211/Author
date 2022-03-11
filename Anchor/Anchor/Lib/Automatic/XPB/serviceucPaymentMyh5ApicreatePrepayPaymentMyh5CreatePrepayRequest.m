#include "serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest.h"
@implementation serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest

+( serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest *)createRequest
{
    serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest* request = [[ serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest alloc] init];
    request.apiName = @"uc.PaymentMyh5Api/createPrepay";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucPaymentMyh5CreatePrepayRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucPaymentMyh5CreatePrepayResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end