#include "apimomentsmainrecommendnextEmptyRequest.h"
@implementation apimomentsmainrecommendnextEmptyRequest

+( apimomentsmainrecommendnextEmptyRequest *)createRequest
{
    apimomentsmainrecommendnextEmptyRequest* request = [[ apimomentsmainrecommendnextEmptyRequest alloc] init];
    request.apiName = @"apimoments.main/recommendnext";
    request.packageName = @"apimoments";
    request.request  = [[apimomentsEmptyRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[apimomentsPublishRespose alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end