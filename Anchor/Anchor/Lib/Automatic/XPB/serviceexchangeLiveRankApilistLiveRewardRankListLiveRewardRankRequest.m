#include "serviceexchangeLiveRankApilistLiveRewardRankListLiveRewardRankRequest.h"
@implementation serviceexchangeLiveRankApilistLiveRewardRankListLiveRewardRankRequest

+( serviceexchangeLiveRankApilistLiveRewardRankListLiveRewardRankRequest *)createRequest
{
    serviceexchangeLiveRankApilistLiveRewardRankListLiveRewardRankRequest* request = [[ serviceexchangeLiveRankApilistLiveRewardRankListLiveRewardRankRequest alloc] init];
    request.apiName = @"exchange.LiveRankApi/listLiveRewardRank";
    request.packageName = @"serviceexchange";
    request.request  = [[serviceexchangeListLiveRewardRankRequest alloc] init];
    request.pb_request = request.request;
    request.respose = [[serviceexchangeListLiveRewardRankResponse alloc]init];
    request.pb_respose = request.respose;
    return request;
}



@end