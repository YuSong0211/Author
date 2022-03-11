#include "serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest.h"
@implementation serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest

+( serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest *)createRequest
{
    serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest* request = [[ serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest alloc] init];
    request.apiName = @"uc.PaymentDirectorApi/listSupportType";
    request.packageName = @"serviceuc";
    request.request  = [[serviceucListSupportTypeRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceucListSupportTypeResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end