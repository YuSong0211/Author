#include "serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest.h"
@implementation serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest

+( serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest *)createRequest
{
    serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest* request = [[ serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest alloc] init];
    request.apiName = @"exchange.AnnouncementApi/listAnnouncement";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListAnnouncementRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListAnnouncementResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end