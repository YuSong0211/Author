#include "appvapiCustomerServiceApilistCategoriesEmptyRequest.h"
@implementation appvapiCustomerServiceApilistCategoriesEmptyRequest

+( appvapiCustomerServiceApilistCategoriesEmptyRequest *)createRequest
{
    appvapiCustomerServiceApilistCategoriesEmptyRequest* request = [[ appvapiCustomerServiceApilistCategoriesEmptyRequest alloc] init];
    request.apiName = @"appvapi.CustomerServiceApi/listCategories";
    request.packageName = @"appvapi";
    request.request  = [[appvapiEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiListCategoryResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end