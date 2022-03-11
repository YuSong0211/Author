#include "appvapiCustomerServiceApilistAllCategoriesAndQuestionEmptyRequest.h"
@implementation appvapiCustomerServiceApilistAllCategoriesAndQuestionEmptyRequest

+( appvapiCustomerServiceApilistAllCategoriesAndQuestionEmptyRequest *)createRequest
{
    appvapiCustomerServiceApilistAllCategoriesAndQuestionEmptyRequest* request = [[ appvapiCustomerServiceApilistAllCategoriesAndQuestionEmptyRequest alloc] init];
    request.apiName = @"appvapi.CustomerServiceApi/listAllCategoriesAndQuestion";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListAllQuestionGroupByCategoryResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end