#include "appvapiCustomerServiceApilistQuestionByCategoryIdIdEncode.h"
@implementation appvapiCustomerServiceApilistQuestionByCategoryIdIdEncode

+( appvapiCustomerServiceApilistQuestionByCategoryIdIdEncode *)createRequest
{
    appvapiCustomerServiceApilistQuestionByCategoryIdIdEncode* request = [[ appvapiCustomerServiceApilistQuestionByCategoryIdIdEncode alloc] init];
    request.apiName = @"appvapi.CustomerServiceApi/listQuestionByCategoryId";
    request.packageName = @"appvapi";
    request.request  = [[appvapiIdEncode alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListQuestionResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end