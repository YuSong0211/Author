#include "appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest.h"
@implementation appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest

+( appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest *)createRequest
{
    appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest* request = [[ appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest alloc] init];
    request.apiName = @"appvapi.AdvertisementStatisticsApi/recordAdvertisement";
    request.packageName = @"appvapi";
    request.request  = [[appvapiRecordAdvertisementRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[appvapiEmptyResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end