#include "apimomentsmainrecommendinitEmptyRequest.h"
@implementation apimomentsmainrecommendinitEmptyRequest

+( apimomentsmainrecommendinitEmptyRequest *)createRequest
{
    apimomentsmainrecommendinitEmptyRequest* request = [[ apimomentsmainrecommendinitEmptyRequest alloc] init];
    request.apiName = @"apimoments.main/recommendinit";
    request.packageName = @"apimoments";
    request.request  = [[apimomentsEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[apimomentsPublishRespose alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end